class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :state
  belongs_to :slot
  has_many :order_services
  has_many :user_services, through: :order_services
  has_one :survey
end
