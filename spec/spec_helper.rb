$LOAD_PATH << File.dirname(__FILE__) + "/../lib"

require 'rubygems'
require 'active_support'
require 'wac'
require 'spec'

begin
  require File.expand_path(File.dirname(__FILE__) + "/setup")
rescue LoadError
  require File.expand_path(File.dirname(__FILE__) + "/setup_example")
end

require 'fakeweb' if Wac::UseFakeweb