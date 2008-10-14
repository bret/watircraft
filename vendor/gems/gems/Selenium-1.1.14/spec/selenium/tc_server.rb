require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'selenium'

module Selenium
describe 'server manager' do
  it 'supports starting and stopping server on specified port' do
    server = Server.on_port(4321)
    server.start
    server.status.should == "started"
    server.stop
    server.status.should == "stopped"
  end

  it 'should support arguments through start method' do
    server = Server.on_port(3333)
    server.start('-timeout 800')
    server.stop
  end
end

end