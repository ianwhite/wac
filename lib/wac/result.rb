module Wac
  class Result
    include XmlContainer
    
    attr_reader :assumptions, :pods
    
    def initialize(xml, options = {})
      @query = options[:query]
      @xml = Nokogiri::XML(xml.to_s).search('queryresult').first
      @xml or raise MissingNodeError, "<queryresult> node missing from xml: #{xml[0..20]}..."
      @assumptions = Assumption.collection(@xml/'assumptions', options)
      types.each {|mixin| extend mixin}
    end
    
    def successful?
      success
    end
    
    # shortcut to the first assumption
    def assumption
      assumptions[0]
    end
    
    def types
      @types ||= xml['datatypes'].split(',').map {|type| Wac.mixin(Result, type)}
    end
    
    def inspect
      out = "A: #{xml['datatypes']}"
      out << " (assumptions: #{assumptions.map(&:name).join(', ')})" if assumptions.present?
      out
    end
  end
end