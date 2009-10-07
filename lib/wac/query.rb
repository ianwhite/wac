module Wac
  class Query
    attr_reader :session
    
    def initialize(session)
      @session = session
    end
  end
end