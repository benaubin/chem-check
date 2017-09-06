require "administrate/base_dashboard"

class ItemSessionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    item: Field::BelongsTo,
    id: Field::String.with_options(searchable: false),
    checked_out_at: Field::DateTime,
    checked_in_at: Field::DateTime,
    usage: Field::Number,
    usage_measurement: Field::String,
    unit: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :item,
    :checked_out_at,
    :checked_in_at,
    :usage_measurement,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :item,
    :id,
    :checked_out_at,
    :checked_in_at,
    :usage_measurement,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :item,
    :checked_out_at,
    :checked_in_at,
    :usage,
    :unit,
  ].freeze

  # Overwrite this method to customize how item sessions are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(session)
    "ItemSession using #{session.usage_measurement} of #{session.item.sku.name}"
  end
end
