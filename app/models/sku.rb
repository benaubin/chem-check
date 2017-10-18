# An SKU is a stock keeping unit, basically a type of item.
# It doesn't represent a physical item, instead a generic type
#
# For example, a specific chemical.
class SKU < ApplicationRecord
  has_many :items

  delegate :total_amount, to: :items

  include PgSearch

  pg_search_scope :search, against: [
      [:name, 'A']
  ], using: {
      tsearch: {prefix: true}
  }
end
