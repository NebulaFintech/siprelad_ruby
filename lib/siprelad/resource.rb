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
      elsif response_body.is_a?(String)
        []
      else
        response_objects << parse_response_object(response_body)
      end
      response_objects
    end

    private

    def self.collection?(field)
      field.is_a?(Hash)
    end

    def self.parse_response_object(response_object)
      object = new
      response_message = nil
      response_object.each do |field|
        response_message = field.last if field.first == :log_error
        set_instance_variables(object, field)
      end
      raise response_message if check_for_errors(response_message)
      object
    end

    def self.check_for_errors(response_message)
      response_message.present? &&
      (response_message.match('/') || response_message.match('Exception') || response_message.match('o se enc')) &&
      !response_message.match('insertado') &&
      !response_message.match('inserto') &&
      !response_message.match('insertada')
    end

    def self.set_instance_variables(object, field)
      k = field.first
      v = field.last
      object.instance_variable_set(:"@#{k}", v) if self::ATTRIBUTES.include?(k.to_sym)
    end

    def self.parse_date(date)
      return date if date.blank?

      date.strftime('%d/%m/%Y')
    end

    def self.parse_gender(gender)
      case gender.to_s.downcase
      when 'male'
        'M'
      when 'female'
        'F'
      else
        raise 'Invalid Gender!'
      end
    end

    def self.parse_country(country)
      case country.to_s.to_s.downcase
      when 'mx'
        1
      else
        raise 'Invalid country!'
      end
    end

    def self.parse_civil_status(civil_status)
      case civil_status.to_s.downcase
      when 'single'
        1
      when 'married'
        2
      else
        3
      end
    end

    def self.parse_housing_type(housing_type)
      case housing_type.to_s.downcase
      when 'owned'
        1
      when 'rent'
        2
      when 'family'
        3
      else
        2
      end
    end

    def self.years_since(date)
      return date if date.blank?

      (Date.current - date.to_date).to_i / 365
    end

    def self.parse_payment_method(payment_method)
      case payment_method
      when :transfer_payment
        '03'
      when :referenced_payment
        '01'
      else
        raise "Unknown payment_method #{payment_method}"
      end
    end

    def self.parse_operation_type(operation_type)
      case operation_type
      when :disbursal
        '08'
      when :payment
        '09'
      when :liquidation
        '41'
      end
    end
  end
end
