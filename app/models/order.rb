class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :state
  belongs_to :slot
  belongs_to :service
  has_one :survey
end
