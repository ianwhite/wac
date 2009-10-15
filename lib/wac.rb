require 'active_support'
require 'nokogiri'

$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'wac/xml_container'
require 'wac/session'
require 'wac/query'
require 'wac/result'
require 'wac/pod'
require 'wac/assumption'

module Wac
  extend self
  
  DefaultQueryURI = "http://preview.wolframalpha.com/api/v1/query.jsp"
  
  attr_accessor :appid
  attr_writer :query_uri
  
  def query_uri
    @query_uri ||= DefaultQueryURI
  end
  
  def new(appid = nil, options = {})
    Session.new(appid || self.appid, options.reverse_merge(:query_uri => self.query_uri))
  end
  
  def query(input, options = {})
    new(options.delete(:appid)).query(input, options)
  end
  
  def fetch(input, options = {})
    new(options.delete(:appid)).fetch(input, options)
  end
  
  # return a module named <type> in <namespace> (create if necessary)
  def mixin(namespace, type)
    Object.const_get "#{namespace.name}::#{type}"
  rescue NameError
    namespace.module_eval "module #{type}; end"
    namespace.const_get type
  end
  
  class MissingNodeError < RuntimeError
  end
end