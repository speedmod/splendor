class CreateDevelopments < ActiveRecord::Migration
  def change
    create_table :developments do |t|
      t.integer :level
      t.string :bonus
      t.integer :point
      t.integer :diamond
      t.integer :sapphire
      t.integer :emerald
      t.integer :ruby
      t.integer :onyx

      t.timestamps
    end
  end
end
