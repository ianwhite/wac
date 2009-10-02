require 'wac/session'

module Wac
  extend self
  
  attr_accessor :appid
  
  def new(appid = self.appid)
    Session.new(appid)
  end
end