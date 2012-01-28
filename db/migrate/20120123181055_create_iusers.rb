class CreateIusers < ActiveRecord::Migration
  def change
    create_table :iusers do |t|
      t.string :name
      t.string :email
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
  def self.down
      drop_table :iusers
  end
end
