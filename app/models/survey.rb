class Survey < ActiveRecord::Base
  belongs_to :order

  scope :provider_surveys, ->(provider_id) { joins(:order).where('orders.provider_id = ?', provider_id).order(created_at: :desc) }
end
