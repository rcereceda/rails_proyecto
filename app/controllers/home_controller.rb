class HomeController < ApplicationController
  def index
  	@providers = User.providers.order(created_at: :desc).limit(8)
  	@services = Service.all
  end
end
