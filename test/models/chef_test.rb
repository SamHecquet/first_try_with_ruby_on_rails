require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Jean Michel", email: 'toto@toto.com', password: "password")  
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chef chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chef chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chef chefname should not be too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
   
  test "chef email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "chef email should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "chef email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "chef email validation should accept valid addresses" do
    valid_addresses = %w[toto@titi.com R8DDD_D@to.ta.org user@example.com first.last@eee.au laura+joe@work.cm]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, "#{va.inspect} should be valid, #{@chef.errors.full_messages.to_s}"
    end
  end
  
  test "chef email validation should reject invalid addresses" do
    invalid_addresses = %w[toto@titi,com R8DDD_Dto.ta.org user@example laura+joe@work+yo.cm]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, "#{ia.inspect} should not be valid"    
    end
  end
  
end