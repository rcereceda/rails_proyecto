class Service < ActiveRecord::Base
	has_many :user_services
	has_many :users, through: :user_services
end
