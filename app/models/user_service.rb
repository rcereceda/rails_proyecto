class UserService < ActiveRecord::Base
	#validates :user_id, presence: true
	validates :service_id, presence: true

  belongs_to :user
  belongs_to :service
  
  has_many :order_services
  has_many :orders, through: :order_services

  delegate :name, to: :service, prefix: true, allow_nil: true
end