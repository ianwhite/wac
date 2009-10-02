require 'wac/session'

module Wac
  extend self
  
  attr_accessor :appid
  
  def new(appid = nil)
    Session.new(appid || self.appid)
  end
  
  def query(*args)
    options = args.extract_options!
    new(options.delete(:appid)).query(*args << options)
  end
end