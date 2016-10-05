class User < ActiveRecord::Base
	validates :name, presence: true
	validates :address, presence: true
	validates :phone, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  
  has_one :schedule, dependent: :destroy
  
  has_many :user_services, dependent: :destroy
  has_many :services, through: :user_services
  
  has_many :orders, -> { order(aasm_state: :asc) }, dependent: :destroy
  has_many :providers, through: :orders

  accepts_nested_attributes_for :user_services, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :schedule

  scope :providers, -> { where(is_provider: true) }
  scope :on_address, ->(address) { where('address LIKE ?', "%#{address}%") }
  scope :has_service, ->(service_id) { joins(:user_services).where('user_services.service_id = ?', service_id) }

  mount_uploader :photo, PhotoUploader

  def default_photo
    "fallback/male_#{(id % 8)+1}.png"
  end

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

  def self.find_for_facebook_oauth(auth)
    user = User.where(auth_provider: auth.provider, uid: auth.uid).first # The User was found in our database
    return user if user
    # Check if the User is already registered without Facebook
    user = User.where(email: auth.info.email).first 
    return user if user
    User.create(
      name: auth.extra.raw_info.name, 
      auth_provider: auth.provider, 
      uid: auth.uid, 
      email: auth.info.email, 
      photo: auth.info.image,
      password: Devise.friendly_token[0,20])
  end

end
