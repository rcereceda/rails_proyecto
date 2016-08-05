class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :provider, class_name: 'User'
  belongs_to :state
  
  has_many :order_services
  has_many :user_services, through: :order_services
  
  has_one :survey
end
