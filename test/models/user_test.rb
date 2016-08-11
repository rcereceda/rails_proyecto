require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:one)
    @service = services(:one)
  end

  test "user must have a name" do
  	@user.name = nil
  	assert_not @user.valid?
  end

  test "user must have a address" do
  	@user.address = nil
  	assert_not @user.valid?
  end

  test "user must have a phone" do
  	@user.phone = nil
  	assert_not @user.valid?
  end

  test "providers must include providers only" do
  	values = User.providers.map(&:is_provider)
  	assert_not_includes values, false
  end

  test "on_address must return users with address like address" do
    # buscar un test que verifique que la palabra de @user.address se encuentre en todos los índices del array
  	values = User.on_address(@user.address).map(&:address)
  	assert_includes values, @user.address
  end

  test "has_service must return users who provides a service" do
    # buscar un test que verifique que el id de @service.id se encuentre en todos user_services del user
    values = User.has_service(@service.id).sample.user_services.map(&:service_id)
    assert_includes values, @service.id
  end
end
