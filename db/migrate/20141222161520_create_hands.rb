class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.integer :player_id
      t.integer :development_id
      t.boolean :hidden

      t.timestamps
    end
  end
end
