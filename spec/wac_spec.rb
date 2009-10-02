require File.dirname(__FILE__) + '/spec_helper'

describe Wac do
  it "should act as namespace for its methods" do
    Wac.ancestors.should include(Wac)
  end
  
  it "should allow setting default appid with .appid" do
    Wac.appid = 'foo123'
    Wac.appid.should == 'foo123'
  end
  
  it ".new(<appid>) should return Wac::Session(<appid>)" do
    Wac::Session.should_receive(:new).with('foo').and_return(session = mock)
    Wac.new('foo').should == session
  end
end
