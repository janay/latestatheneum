class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :authors
      t.integer :isbn
      t.integer :user_id

      t.timestamps
  end
    
    add_index :books, [:user_id, :created_at]
  end
  
  def self.down
    drop_table :books
  end
  
end
