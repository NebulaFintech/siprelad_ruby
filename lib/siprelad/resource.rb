module Siprelad
  class Resource
    def initialize(options = {}); end

    def self.parse_response(response, operation)
      response_body = response[:"#{operation}_response"][:"#{operation}_result"].first[1]
      response_objects = []
      if collection?(response_body.first)
        response_body.each do |response_object|
          response_objects << parse_response_object(response_object)
        end
      else
        response_objects << parse_response_object(response_body)
      end
      return response_objects
    end

    private

    def self.collection?(field)
      field.is_a?(Hash)
    end

    def self.parse_response_object(response_object)
      object = new
      response_object.each do |field|
        set_instance_variables(object, field)
      end
      object
    end

    def self.set_instance_variables(object, field)
      k = field.first
      v = field.last
      object.instance_variable_set(:"@#{k}", v) if self::ATTRIBUTES.include?(k.to_sym)
    end
  end
end
