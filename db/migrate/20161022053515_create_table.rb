class CreateTable < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :like
      t.integer :post_id,:user_id
      t.timestamps
      t.timestamps null: false
    end
  end
end
