require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@service = services(:one)
  end

  test "service must have a name" do
  	@service.name = nil
  	assert_not @service.valid?
  end

  test "service name can't be repeated" do 
  	Service.create(name: 'Gasfiter (agua)')
  	service = Service.new(name: 'Gasfiter (agua)')
  	assert_not service.valid?
  end
end
