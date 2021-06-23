module Siprelad
  class Configuration
    attr_accessor :wsdl, :connection,
      :open_timeout, :read_timeout,
      :user, :password

    def initialize
      @open_timeout = 5
      @read_timeout = 5
      @wsld = ENV['SIPRELAD_ELB'].to_s + ENV['SIPRELAD_WSDL'].to_s
    end

    def namespaces
      {
        'xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/',
        'xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema',
        'xmlns:tem' => 'http://tempuri.org/'
      }
    end
  end
end
