module Wac
  # mixin this module to get sensible default methods for xml container classes
  module XmlContainer
    attr_reader :xml
    
    def respond_to?(method, include_private = false)
      xml.key?(method.to_s) || super
    end
    
  protected
    def xml_value(val)
      case val
      when "true" then true
      when "false" then false
      when "" then nil
      when /^\d+$/ then val.to_i
      when /^\d+\.\d+$/ then val.to_f
      else val
      end
    end
      
    def method_missing(method, *args)
      if xml.key?(method.to_s)
        xml_value(xml[method.to_s])
      else
        super
      end
    end
  end
end