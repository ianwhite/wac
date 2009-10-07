module Wac
  # Keeps hold of options that are sent with every query.
  # Creates queries, 
  class Session
    attr_reader :appid
    
    def initialize(appid)
      raise ArgumentError, "Wac::Session requires an appid" unless appid
      @appid = appid
    end
    
    def query(input, options = {})
      
    end
  end
end