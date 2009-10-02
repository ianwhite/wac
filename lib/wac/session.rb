module Wac
  class Session
    attr_reader :appid
    
    def initialize(appid)
      @appid = appid
    end
  end
end