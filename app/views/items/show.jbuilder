json.item do
  json.(@item, :code, :amount, :unit)
  json.checkedOut @item.checked_out?

  json.sku(@item.sku, :name, :id)
end