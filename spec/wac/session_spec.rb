require File.dirname(__FILE__) + '/../spec_helper'

describe Wac::Session do
  it ".new(nil) should raise an ArgumentError" do
    lambda { Wac::Session.new(nil) }.should raise_error(ArgumentError)
  end
  
  describe ".new(<appid>)" do
    before do
      @session = Wac::Session.new('id1234')
    end
    
    it "should have appid of <appid>" do
      @session.appid.should == 'id1234'
    end
  end
end
