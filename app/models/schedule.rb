class Schedule < ActiveRecord::Base
  validates :starttime, presence: true
  validates :endtime, presence: true

  before_save :set_active

	belongs_to :user

  def set_active
    self.active = true
  end
end
