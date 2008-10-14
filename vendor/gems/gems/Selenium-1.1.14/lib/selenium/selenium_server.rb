require 'net/http'

module Selenium

  # Selenium server driver that provides API to start/stop server and check if
  # server is running.
  # NOTE: The start does not return until the server shuts down.
  class SeleniumServer

    def SeleniumServer::run(argv, vmparameter='')
      jar_file = SeleniumServer.jar_file
      if (argv[0] == '-stop')
        server = SeleniumServer.new(argv[1])
        puts "stopping server on port #{server.port_number}"
        server.stop
      elsif argv[0] == '-check'
        server = SeleniumServer.new(argv[1])
        if (server.running?)
          puts "server running on #{server.port_number}"
        else
          puts "server not running on #{server.port_number}"
        end
      else
        command = "java #{vmparameter} -jar #{jar_file} #{argv.join(' ')}"
        puts command
        system(command)
      end
    end

    private
    def SeleniumServer::jar_file
      File.join(File.dirname(__FILE__), 'openqa', 'selenium-server.jar.txt')
    end

    public
    attr_reader :port_number, :request_timeout
    # Turn off INFO level server logs, only WARN and above message will be printed
    attr_accessor :print_log

    # Initialize the server driver with an opitonal port number (default to 4444)
    # and request timeout (default to 30)
    def initialize(port_number_to_use = 4444, request_timeout=30)
      port_number_to_use = 4444 unless port_number_to_use
      @port_number = port_number_to_use
      @request_timeout = request_timeout
      @print_log = false
    end

    def port_number
      @port_number
    end

    # Starts the Selenium server.  This does not return until the server is shutdown.
    def start(*argv)
      logging_option = ''
      logging_option = '-Dorg.apache.commons.logging.Log=org.apache.commons.logging.impl.SimpleLog -Dorg.apache.commons.logging.simplelog.defaultlog=warn' unless @print_log
      SeleniumServer.run(['-port', port_number.to_s, '-timeout', request_timeout.to_s] + argv, logging_option)
    end

    # Stops the Selenium server
    def stop
      Net::HTTP.get('localhost', '/selenium-server/driver/?cmd=shutDown', @port_number)
    end

    # Check if the Selenium is running by sending a test_complete command with invalid session ID
    def running?
      begin
        ping
      rescue Errno::EBADF, Errno::ECONNREFUSED => e
        return false
      end
      return true
    end

    # ping the server to see if it is running, raises error if not
    # returns the ping status
    def ping
      url = URI.parse("http://localhost:#{@port_number}/selenium-server/driver/?cmd=testComplete&sessionId=smoketest")
      request = Net::HTTP::Get.new(url.path)
      Net::HTTP.start(url.host, url.port) {|http|
        http.read_timeout=5
        http.request(request)
      }
    end
  end
end