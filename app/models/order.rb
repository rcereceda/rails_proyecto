class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :provider, class_name: 'User'
  belongs_to :state
  
  has_many :order_services, dependent: :destroy
  has_many :user_services, through: :order_services
  
  has_one :survey

  accepts_nested_attributes_for :order_services, :reject_if => :all_blank, :allow_destroy => true

  delegate :name, to: :provider, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :provider_orders, ->(provider_id) { where(provider_id: provider_id).order(aasm_state: :asc) }

  aasm do
    state :pending, initial: true
    state :confirmed, :finished, :rejected

    event :confirm do
      transitions from: :pending, to: :confirmed
    end

    event :finish do
      transitions from: :confirmed, to: :finished
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end

    event :rollback do
      transitions from: :confirmed, to: :rejected
    end
  end
end
