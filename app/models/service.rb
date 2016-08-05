class Service < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	has_many :user_services
	has_many :users, through: :user_services
end
