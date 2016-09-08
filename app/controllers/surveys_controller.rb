class SurveysController < ApplicationController
	
	def create
		@order = Order.find(params[:order_id])
		@survey = Survey.new(survey_params)
		@survey.order = @order

		respond_to do |format|
		  if @survey.save
		    format.html { redirect_to provider_order_path(current_user.id, @order.id), notice: 'Survey was successfully created.' }
		    format.json { render :show, status: :created, location: @claim }
		  else
		    format.html { render :new }
		    format.json { render json: @claim.errors, status: :unprocessable_entity }
		  end
		end
	end

	private
	  # Use callbacks to share common setup or constraints between actions.
	  def set_survey
	    @survey = Survey.find(params[:id])
	  end

	  # Never trust parameters from the scary internet, only allow the white list through.
	  def survey_params
	    params.require(:survey).permit(:stars, :comments)
	  end

end
