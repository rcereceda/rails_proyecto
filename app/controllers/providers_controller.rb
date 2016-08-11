class ProvidersController < ApplicationController
  def index
  	service = params[:service]
  	address = params[:address]

  	@providers = User.providers

  	if address.present?
  		@providers = @providers.on_address(address)
  	end

  	if service.present?
  		@providers = @providers.has_service(service)
  	end
  end
end
