module Wac
  class Session
    attr_reader :appid
    
    def initialize(appid)
      raise ArgumentError, "Wac::Session requires an appid" unless appid
      @appid = appid
    end
  end
end