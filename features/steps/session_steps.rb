When /^I set the default appid: "(.+?)"$/ do |appid|
  Wac.appid = appid
end

When /^I ask for a session$/ do
  @session = Wac.new
end

When /^I ask for a session with appid: "(.+?)"$/ do |appid|
  @session = Wac.new(appid)
end

Then /^I should have a session with appid: "(.+?)"$/ do |appid|
  @session.should be_kind_of(Wac::Session)
  @session.appid.should == appid
end