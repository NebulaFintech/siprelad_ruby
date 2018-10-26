require 'siprelad/version'
require 'siprelad/mixins/select'
require 'siprelad/mixins/insert'
require 'siprelad/resource'
require 'siprelad/person'
require 'siprelad/requestor'
require 'siprelad/configuration'
require 'savon'
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
      puts build_request(builder).inspect
      response ||= call_with_logging build_request(builder)

      raise_expected_httpi_response! unless response.is_a?(HTTPI::Response)

      create_response(response)
    end
  end
end
module Siprelad
  require 'active_support'
  require 'active_support/core_ext'

  def self.configure
    yield(configuration)
    set_connection(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  private

  def self.set_connection(configuration)
    configuration.connection = Savon.client(
      wsdl: configuration.wsdl,
      open_timeout: configuration.open_timeout,
      read_timeout: configuration.read_timeout,
      env_namespace: 'soap',
      namespace_identifier: '',
      namespaces: configuration.namespaces,
      element_form_default: :qualified
    )
  end
end
