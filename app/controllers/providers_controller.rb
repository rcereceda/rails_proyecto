class ProvidersController < ApplicationController
	before_action :set_provider, only: [:show]

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

    if @providers.blank?
      flash[:notice] = "No hemos encontrado resultados..."
    end
  end

  def show
  	@schedule = @provider.schedule
  end

  private

  def set_provider
  	@provider = User.find(params[:id])
  end
end
