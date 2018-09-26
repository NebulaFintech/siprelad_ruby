module Siprelad
  class Resource
    def initialize(options = {}); end

    def self.parse_response(response, operation)
      obj = new
      response[:"#{operation}_response"][:"#{operation}_result"].first[1].each do |k, v|
        obj.instance_variable_set(:"@#{k}", v) if self::ATTRIBUTES.include?(k.to_sym)
      end
      obj
    end
  end
end
