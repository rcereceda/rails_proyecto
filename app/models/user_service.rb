class UserService < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :order_services
  has_many :orders, through: :order_services
end
