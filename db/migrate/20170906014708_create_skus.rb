class CreateSKUs < ActiveRecord::Migration[5.1]
  def change
    create_table :skus, id: :uuid do |t|
      t.string :type
      t.string :name

      t.index :type
      t.index :name

      t.timestamps
    end
  end
end
