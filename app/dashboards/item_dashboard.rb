require "administrate/base_dashboard"

class ItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    sku: Field::BelongsTo,
    id: Field::String.with_options(searchable: false),
    barcode: BarcodeField,
    code: Field::String,
    amount: Field::Number,
    unit: Field::String,
    checked_out?: Field::Boolean,
    measurement: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :sku,
    :measurement,
    :checked_out?,
    :code,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :sku,
    :id,
    :checked_out?,
    :code,
    :barcode,
    :measurement,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :sku,
    :code,
    :amount,
    :unit,
  ].freeze

  # Overwrite this method to customize how items are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(item)
    "#{item.measurement.try :to_s, :symbol} Item of #{item.try(:sku).try :name}"
  end
end
