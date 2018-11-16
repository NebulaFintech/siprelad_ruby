module Savon
  class Operation
    def call(locals = {}, &block)
      builder = build(locals, &block)
      response = Savon.notify_observers(@name, builder, @globals, @locals)
      puts build_request(builder).body
      response ||= call_with_logging build_request(builder)
      puts response.body

      raise_expected_httpi_response! unless response.is_a?(HTTPI::Response)

      create_response(response)
    end
  end
end
