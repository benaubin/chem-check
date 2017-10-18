json.extract! session, :id, :checked_out_at, :checked_in_at, :usage, :unit

json.item session.item, partial: 'items/item', as: :item