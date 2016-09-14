class User < ActiveRecord::Base
	validates :name, presence: true
	validates :address, presence: true
	validates :phone, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one :schedule, dependent: :destroy
  
  has_many :user_services, dependent: :destroy
  has_many :services, through: :user_services
  
  has_many :orders, -> { order(aasm_state: :asc) }
  has_many :providers, through: :orders

  accepts_nested_attributes_for :user_services, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :schedule

  scope :providers, -> { where(is_provider: true) }
  scope :on_address, ->(address) { where('address LIKE ?', "%#{address}%") }
  scope :has_service, ->(service_id) { joins(:user_services).where('user_services.service_id = ?', service_id) }

  def provider_score
    surveys = provider_surveys
    if surveys.blank?
      0
    else
      surveys.average(:stars).round(2).try(:to_f)
    end
  end

  def provider_reviews
    surveys = provider_surveys
    if surveys.blank?
      0
    else
      surveys.count
    end
  end

  def provider_surveys
    Survey.provider_surveys(self.id)
  end

end
