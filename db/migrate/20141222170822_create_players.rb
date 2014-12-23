class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :seq
      t.string :name
      t.integer :diamond
      t.integer :sapphire
      t.integer :emerald
      t.integer :ruby
      t.integer :onyx

      t.timestamps
    end
  end
end
