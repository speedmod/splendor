class AddColumnToDevelopment < ActiveRecord::Migration
  def change
    add_column :developments, :player_id, :integer
  end
end
