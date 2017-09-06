require 'barby/barcode/code_128'

# An item is something physical that can be checked out.
# It represents a single, physical item.
#
# for example, a can of chemicals
class Item < ApplicationRecord
  belongs_to :sku, required: true

  has_many :item_sessions

  class <<self
    def total_amount
      begin
        all.map(&:measurement).sum
      rescue TypeError
        'Undefined Amount'
      end
    end
  end

  def checked_out?
    !current_sessions.empty?
  end

  def current_sessions
    item_sessions.where(checked_in_at: nil)
  end

  def measurement
    return BigDecimal(0) if amount == BigDecimal(0)
    Unitwise(amount, unit)
  end

  def measurement=(m)
    self.amount = m.value
    self.unit = m.unit
  end

  def barcode
    Barby::Code128A.new(self.code)
  end
end
