class AddColumnToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :gold, :integer
  end
end
