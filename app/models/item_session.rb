# an item session
class ItemSession < ApplicationRecord
  belongs_to :item

  after_save :use_item

  validates :checked_out_at, presence: true

  validates_uniqueness_of :checked_in_at, scope: :item_id

  def usage_measurement
    Unitwise(usage, unit || item.unit)
  end

  def usage_measurement_was
    Unitwise(usage_was || 0, unit_was || unit)
  end

  def usage
    super || 0
  end

  def unit
    super || item.try(:unit)
  end

  def use_item
    return if unit.nil?
    item.measurement -= (usage_measurement - usage_measurement_was)
    item.save!
  end
end
