class AddStatusToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :status, :boolean, :default => true
  end
  
  def self.down
    remove_column :books, :status
  end
end
