When /^I ask for a session with appid: "(.+?)"$/ do |appid|
  @session = Wac.new(key)
end

Then /^I should have a session with appid: "(.+?)"$/ do |appid|
  @session.should be_kind_of(Wac::Session)
  @session.appid.should == appid
end