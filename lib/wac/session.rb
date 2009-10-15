module Wac
  # Keeps hold of options that are sent with every query.
  # Creates queries
  class Session
    attr_accessor :appid, :query_uri, :options
    
    def initialize(appid, options = {})
      raise ArgumentError, "Wac::Session requires an appid" unless appid
      @appid = appid
      @query_uri = options.delete(:query_uri) || Wac.query_uri
      @options = options
    end
    
    def query_options
      options.merge(:appid => appid)
    end
    
    def query(input, options = {})
      Query.new(input, options.merge(:session => self))
    end
    
    def fetch(input, options = {})
      query(input, options).fetch
    end
  end
end