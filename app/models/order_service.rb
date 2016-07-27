class OrderService < ActiveRecord::Base
  belongs_to :order
  belongs_to :user_service
end
