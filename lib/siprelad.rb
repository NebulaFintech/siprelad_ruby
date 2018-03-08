require "siprelad/version"
require "siprelad/mixins/select"
require "siprelad/mixins/insert"
require "siprelad/resource"
require "siprelad/person"
require "siprelad/requestor"
require "savon"
module Savon
  class Response
    def initialize(http, globals, locals)
      @http    = http
      @globals = globals
      @locals  = locals
      puts http.inspect
      build_soap_and_http_errors!
      raise_soap_and_http_errors! if @globals[:raise_errors]
    end
  end
  class Operation
    def call(locals = {}, &block)
      builder = build(locals, &block)
      response = Savon.notify_observers(@name, builder, @globals, @locals)
      response ||= call_with_logging build_request(builder)

      raise_expected_httpi_response! unless response.kind_of?(HTTPI::Response)

      create_response(response)
    end
  end
end
module Siprelad
  require 'active_support'
  require 'active_support/core_ext'

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    require 'savon'
    WSDL = 'http://internal-elb-shared-priv-pld-1296134306.us-east-1.elb.amazonaws.com/WCF_PLD/Service.svc?wsdl'
    attr_accessor :open_timeout, :read_timeout, :user, :password, :connection

    def initialize
      @open_timeout = 5
      @read_timeout = 5
      @user = nil
      @password = nil
      @connection = Savon.client(wsdl: WSDL, open_timeout: @open_timeout, read_timeout: @read_timeout, element_form_default: :qualified)
    end
  end
end