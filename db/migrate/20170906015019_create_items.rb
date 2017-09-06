class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items, id: :uuid do |t|
      t.references :sku, foreign_key: true, type: :uuid
      t.string :code
      t.integer :amount
      t.citext :unit

      t.index :code, unique: true

      t.timestamps
    end
  end
end
