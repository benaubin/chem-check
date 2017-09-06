class CreateItemSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :item_sessions, id: :uuid do |t|
      t.datetime :checked_out_at
      t.datetime :checked_in_at
      t.index :checked_in_at

      t.references :item, foreign_key: true, type: :uuid

      t.integer :usage, default: 0
      t.citext :unit

      t.timestamps
    end
  end
end
