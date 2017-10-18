class AddDetailsToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :details, :text
  end
end
