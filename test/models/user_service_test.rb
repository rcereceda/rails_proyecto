require 'test_helper'

class UserServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user_service = user_services(:one)
  end

  # test "model must have a user id" do
  # 	@user_service.user_id = nil
  # 	assert_not @user_service.valid?
  # end

  test "model must have a service id" do
  	@user_service.service_id = nil
  	assert_not @user_service.valid?
  end
end
