require 'fakeweb'

Wac.appid = Wac::TestingAppid

FakeWeb.allow_net_connect = false

pi_result = File.read(File.join(File.dirname(__FILE__), 'pi_result.xml'))

uri = Wac.query_uri + '?' + {:appd => Wac.appid, :input => 'pi'}.to_query

FakeWeb.register_uri :get, Wac.query_uri + '?' + {:appid => Wac.appid, :input => 'pi'}.to_query, :body => pi_result
