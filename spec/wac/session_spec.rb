require File.dirname(__FILE__) + '/../spec_helper'

describe Wac::Session do
  describe ".new(<appid>)" do
    before do
      @session = Wac::Session.new('id1234')
    end
    
    it "should have appid of <appid>" do
      @session.appid.should == 'id1234'
    end
  end
end
