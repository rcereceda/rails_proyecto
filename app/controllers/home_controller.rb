class HomeController < ApplicationController
  def index
  	@providers = User.providers.includes(:services).order(created_at: :desc).limit(8)
  	@services = Service.all
  end
end
