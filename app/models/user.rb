class User < ActiveRecord::Base
	validates :name, presence: true
	validates :address, presence: true
	validates :phone, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :schedule
  
  has_many :user_services
  has_many :services, through: :user_services
  
  has_many :orders
  # has_many :providers, through: :orders

  scope :providers, -> { where(is_provider: true) }
  scope :on_address, ->(address) { where('address LIKE ?', "%#{address}%") }
  scope :has_service, ->(service_id) { joins(:user_services).where('user_services.service_id = ?', service_id) }

end
