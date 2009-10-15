require File.dirname(__FILE__) + '/spec_helper'

describe Wac do
  it "should act as namespace for its methods" do
    Wac.ancestors.should include(Wac)
  end
  
  it "should allow setting default appid with .appid" do
    Wac.appid = 'foo123'
    Wac.appid.should == 'foo123'
  end
  
  it ".new(<appid>) should return Wac::Session(<appid>, :query_uri => <uri>)" do
    Wac::Session.should_receive(:new).with('foo', :query_uri => Wac.query_uri).and_return(session = mock)
    Wac.new('foo').should == session
  end
  
  it ".query(<query>) should create a session on demand and send query to that" do
    Wac.should_receive(:new).and_return(session = mock)
    session.should_receive(:query).with("foo", {})
    Wac.query("foo", {})
  end
  
  it ".query('foo', :appid => '1234') should create a session with that appid and send query to that" do
    Wac.should_receive(:new).with("1234").and_return(session = mock)
    session.should_receive(:query).with('foo', {})
    Wac.query("foo", :appid => '1234')
  end
end
