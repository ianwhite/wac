$LOAD_PATH << File.dirname(__FILE__) + "/../lib"

require 'rubygems'
require 'wac'
require 'spec'

begin
  require File.expand_path(File.join(File.dirname(__FILE__), "setup"))
rescue LoadError
  require File.expand_path(File.join(File.dirname(__FILE__), "setup_example"))
end

require File.expand_path(File.join(File.dirname(__FILE__), "fakeweb")) if Wac::UseFakeweb