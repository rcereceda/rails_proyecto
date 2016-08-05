require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:one)
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
end
