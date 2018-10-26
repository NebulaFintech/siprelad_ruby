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