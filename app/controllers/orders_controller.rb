class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_order_, only: [:reject, :finish, :confirm]
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    unless current_user.is_provider?
      @orders = current_user.orders.includes(:order_services)
    else
      @orders = Order.provider_orders(current_user.id).includes(:order_services)
      @orders_chart = @orders.group_by_day(:date).count
      @orders = @orders.order(aasm_state: :asc)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @survey = @order.survey || Survey.new
  end

  # GET /orders/new
  def new
    @provider = User.find(params[:provider_id])
    @order = Order.new
    @order_service = OrderService.new
  end

  # GET /orders/1/edit
  def edit
    @provider = User.find(params[:provider_id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user

    respond_to do |format|
      if @order.save
        format.html { redirect_to provider_order_path(@order.provider_id, @order.id), notice: 'Tu pedido ha sido creado con éxito' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    #render json:params
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to user_orders_path(current_user.id), notice: 'Tu pedido se ha actualizado con éxito' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to user_orders_path(current_user.id), notice: 'La orden ha sido cancelada' }
      format.json { head :no_content }
    end
  end

  # AASM states
  def confirm
    @order.confirm!
    respond_to do |format|
      format.html { redirect_to provider_orders_path(current_user.id), notice: 'La orden ha sido confirmada' }
    end
  end

  def finish
    @order.finish!
    respond_to do |format|
      format.html { redirect_to provider_orders_path(current_user.id), notice: 'La orden ha sido terminada' }
    end
  end

  def reject
    @order.reject!
    respond_to do |format|
      format.html { redirect_to user_orders_path(current_user.id), notice: 'La orden ha sido cancelada' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_order_
      @order = Order.find(params[:order_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:date, :description, :information, :user_id, :provider_id, order_services_attributes: [:id, :user_service_id, :_destroy])
    end
end
