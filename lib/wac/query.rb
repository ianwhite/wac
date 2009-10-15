require 'open-uri'

module Wac
  # responsible for constructing a query, and returning the io stream for the query, and creating a Result
  # has a session object, input, and options
  class Query
    include OpenURI
    
    attr_accessor :session, :input, :options
    
    def initialize(input, options = {})
      @input = input
      @session = options.delete(:session)
      @options = options
    end
    
    # has the result been fetched?
    def fetched?
      @result ? true : false
    end
    
    # go and fetch the result, this is done automaticaly if you ask for the result
    def fetch
      @result = Result.new(data, :query => self)
    end
    
    # the query result
    def result
      fetch unless fetched?
      @result
    end
    
    # the uri that this query will issue a get request to
    def uri
      "#{query_uri}?#{query_options.to_query}"
    end
    
    # the full set of options used to make this query, including those inherited form the session
    def query_options
      opts = options.merge(:input => input)
      session ? session.query_options.merge(opts) : opts
    end
    
    def data
      open(uri).read
    end
    
    # use session query_uri, or Wac.query_uri if no session available
    def query_uri
      session ? session.query_uri : Wac.query_uri
    end
    
    def inspect
      out = "q: \"#{input}\""
      out << " #{options[:podstate]}" if options[:podstate]
      out << " (assuming #{options[:assumption]})" if options[:assumption]
      out << ", a: #{result.datatypes}" if fetched?
      out
    end
  end
end