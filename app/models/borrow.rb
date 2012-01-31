class Borrow < ActiveRecord::Base
  attr_accessible :book_id, :borrower_id
  
  belongs_to :borrower, :class_name => "User"
  belongs_to :book, :class_name => "Book"
 

end
