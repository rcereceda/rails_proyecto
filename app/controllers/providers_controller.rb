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
  end

  def show
  	@surveys = Survey.provider_surveys(@provider.id)

    if @surveys.blank?
      @avg_stars = 0
    else
      @avg_stars = @surveys.average(:stars).round(2)
    end
  end

  private

  def set_provider
  	@provider = User.find(params[:id])
  end
end
