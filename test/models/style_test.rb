# == Schema Information
#
# Table name: styles
#
#  id   :integer          not null, primary key
#  name :string
#

require 'test_helper'

class StyleTest < ActiveSupport::TestCase
  
  def setup
    @style = Style.new(name: "French")  
  end
  
  test "style should be valid" do
    assert @style.valid?
  end
  
  test "style name should be present" do
    @style.name = " "
    assert_not @style.valid?
  end
  
  test "style name should not be too long" do
    @style.name = "a" * 26
    assert_not @style.valid?
  end
  
  test "style name should not be too short" do
    @style.name = "a"
    assert_not @style.valid?
  end
  
    
  test "style name should be unique" do
    @style.save
    
    style = Style.new(name: "French")  
    assert_not style.valid?
    
    styleCaps = Style.new(name: "FRENCH")  
    assert_not styleCaps.valid?
  end
  
end
