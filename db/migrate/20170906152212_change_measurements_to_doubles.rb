class ChangeMeasurementsToDoubles < ActiveRecord::Migration[5.1]
  def up
    change_column :item_sessions, :usage, :decimal, precision: 9, scale: 3
    change_column :items, :amount, :decimal, precision: 12, scale: 6
  end
  def down
    change_column :item_sessions, :usage, :integer
    change_column :items, :amount, :integer
  end
end
