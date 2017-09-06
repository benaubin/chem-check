# an item session
class ItemSession < ApplicationRecord
  belongs_to :item

  after_save :use_item

  validates :checked_out_at, presence: true

  validates_uniqueness_of :checked_in_at, scope: :item_id

  def usage_measurement
    Unitwise(usage, unit || item.unit)
  end

  def usage_measurement_change
    usage_measurement - usage_measurement_before_last_save
  end

  def usage_measurement_before_last_save
    Unitwise(usage_before_last_save || BigDecimal(0), unit_before_last_save || unit)
  end

  def usage
    super || BigDecimal(0)
  end

  def unit
    super || item.try(:unit)
  end

  def use_item
    return if unit.nil?
    item.measurement -= usage_measurement_change
    item.save!
  end
end
