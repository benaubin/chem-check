# an item session
class ItemSession < ApplicationRecord
  belongs_to :item

  after_save :use_item

  validates :checked_out_at, presence: true

  validates_uniqueness_of :checked_in_at, scope: :item_id

  def amount_at_end=(end_amount)
    return false if end_amount.nil? || end_amount.empty?
    self.usage = BigDecimal(item.amount) - BigDecimal(end_amount)
  end

  def amount_at_end
    nil
  end

  def usage_measurement
    Unitwise(usage, unit)
  end

  def usage_measurement_change
    usage_measurement - usage_measurement_before_last_save
  end

  def usage_measurement_before_last_save
    Unitwise(usage_before_last_save || BigDecimal(0), unit_before_last_save)
  end

  def usage
    super || BigDecimal(0)
  end

  def unit
    super if super && !super.empty?
    item.try :unit
  end

  def unit_before_last_save
    super if super && !super.empty?
    item.try :unit
  end

  def use_item
    return if unit.nil?
    item.measurement -= usage_measurement_change
    item.save!
  end
end
