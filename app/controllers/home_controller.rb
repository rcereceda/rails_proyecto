class HomeController < ApplicationController
  def index
  	@providers = User.providers
  	@services = Service.all
  end
end
