module FormHelper
  def setup_order(order, provider)
		(provider.user_services - order.user_services).each do |user_service|
			order.order_services.build(:user_service => user_service)
		end
		order
  end
end