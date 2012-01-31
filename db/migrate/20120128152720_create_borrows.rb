class CreateBorrows < ActiveRecord::Migration
  def self.up
    create_table :borrows do |t|
      t.integer :borrower_id
      t.integer :book_id

      t.timestamps
    end
    
    add_index :borrows, :borrower_id
    add_index :borrows, :book_id, :unique => true
    add_index :borrows, [:borrower_id, :book_id], :unique => true
    
    end 
    def self.down
      drop_table :borrows
  end
end
