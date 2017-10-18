json.extract! sku, :id, :name

json.items sku.items, partial: 'items/item', as: :item