class Book < ActiveRecord::Base
  attr_accessible :title, :authors, :isbn
  belongs_to :user
  
  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :authors, :presence => true
  
  validates :user_id, :presence => true
  
  default_scope :order => 'books.created_at DESC'
  
  # Return books from the users being followed by the given user.
   scope :from_users_followed_by, lambda { |user| followed_by(user) }
    
  
  private

      # Return an SQL condition for users followed by the given user.
      # We include the user's own id as well.
      def self.followed_by(user)
            following_ids = %(SELECT followed_id FROM relationships
                              WHERE follower_id = :user_id)
            where("user_id IN (#{following_ids}) OR user_id = :user_id",
                  { :user_id => user })
          end
end
