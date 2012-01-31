require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :city, :state, :country
  has_many :books, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id",
                             :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                     :class_name => "Relationship",
                                     :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  has_many :borrows, :foreign_key => "borrower_id",
                     :dependent => :destroy

  has_many :borrowing, :through => :borrows, :source => :book
  
                     
    
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,    :presence => true, 
                      :length   => { :maximum => 50 }
  validates :email,   :presence => true, 
                      :format   => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }
  validates :city,    :presence => true
  validates :country, :presence => true
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password,:presence     => true,
                      :confirmation => true,
                      :length       => { :within => 4..40 }
  before_save :encrypt_password
  scope :admin, where(:admin => true)
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
    
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
  end
  
  def following?(followed)
      relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
      relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
      relationships.find_by_followed_id(followed).destroy
  end
    
  def feed
        Book.from_users_followed_by(self)    
  end
  
  def borrowing?(book)
  !((borrows.find_by_book_id(book)).nil?)
  end
  
  def borrow!(book)
  borrows.create!(:book_id => book)
  #book.changestatus
  end
  
  def unborrow!(book)
    puts "********************** unborrow"
    puts (borrows.find_by_book_id(book)).nil?
    (borrows.find_by_book_id(book)).destroy
    #book.changestatus
  end
  
  def borrowers
    borrowedbooks=[]
    books.each do |book|
      if !((book.borrowers).nil?)
        borrowedbooks << book
      end 
    end 
      return borrowedbooks
  end 

  def numlents
      lents=0;
      books.each do |book|
        if !((book.borrowers).nil?)
          lents=lents+1
        end 
      end 
        return lents
    end 
 
  
  
      
  
  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
          

end
