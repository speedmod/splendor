class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :level
      t.integer :card_id

      t.timestamps
    end
  end
end
