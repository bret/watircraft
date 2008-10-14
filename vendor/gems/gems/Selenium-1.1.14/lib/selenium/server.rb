require 'uri'

module Selenium
# The class that can manages the server driver classes.
# This class is originally copied from the BuildMaster project.
# You can setup your build task to start the server before
# the tests and shutdown when it is finished
#   server = Selenium::Server.new()
#   begin
#     server.start
#     tests.run # run your tests here
#   ensure
#     server.stop
#   end
class Server
  # The status of the server.  Values are
  # * stopped
  # * starting
  # * started
  # * stopping
  # * error
  attr_reader :status

  # The timeout setting for selenium in seconds
  attr_reader :timeout

  def Server::on_port(port)
    Server.new(SeleniumServer.new(port))
  end

  # Create a selenium server that can be controlled directly
  def initialize(port_number, timeout=60)
    if port_number.is_a? SeleniumServer
      # backward compatibility, to be removed in 2.0
      @server = port_number 
    else
      @server = SeleniumServer.new(port_number, timeout)
    end
    @status = 'stopped'
  end

  def print_log=(value)
    @server.print_log = value
  end

  # Starts the server, returns when the server is up and running
  def start(*argv)
    puts "starting selenium server..."
    starting_server(*argv)
    wait_for_condition {@server.running?}
    puts "started selenium server"
    @status = 'started'
  end

  def driver(browser_start_command, browser_url)
    SeleniumDriver.new('localhost', @server.port_number, browser_start_command, browser_url, @server.request_timeout * 1000)
  end

  def open(browser_start_command, browser_url)
    url = URI.parse(browser_url)
    browser = driver(browser_start_command, URI::Generic::new(url.scheme, url.userinfo, url.host, url.port, nil, nil, nil, nil, nil))
    browser.start
    browser.open(url.request_uri)
    page = WebPage.new(browser)
    page.wait_for_load
    page
  end

  # Starts the server, does not return until the server shuts down
  def run(*argv)
    @server.start(*argv)
  end

  # Stops the server, returns when the server is no longer running
  def stop
    puts "stopping selenium server..."
    stopping_server
    wait_for_condition {not @server.running?}
    puts "stopped selenium server."
    @status = 'stopped'
  end

  private
  def starting_server(*argv)
    @status = 'starting'
    ['INT', 'TERM'].each { |signal|
         trap(signal){ @server.stop}
    }
    start_thread {run(*argv)}
  end

  def stopping_server
    @status = 'stopping'
    start_thread {@server.stop}
  end

  def start_thread
    Thread.new do
      begin
        yield
      rescue Exception => exception
        @exception = exception
      end
    end
  end

  def wait_for_condition
    count = 0
    sleep 1
    while not (result = yield)
      if (@exception)
        error = @exception
        @exception = nil
        @status = 'error'
        raise error
      end
      count = count + 1
      raise 'wait timed out' unless count < 10
      sleep 1
    end
  end

end
end