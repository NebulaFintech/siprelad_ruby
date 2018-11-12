module Siprelad
  class Configuration
    attr_accessor :environment, :wsdl, :connection, :open_timeout, :read_timeout,
                  :user, :password

    def initialize
      @open_timeout = 5
      @read_timeout = 5
      @environment = ENV['RAILS_ENV']
      @wsdl = 'https://pld.gonebula.io/WCF_PLD/ServicePLD.svc?singleWsdl'
    end

    def namespaces
      {
        'xmlns:soap' => 'http://schemas.xmlsoap.org/soap/envelope/',
        'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
        'xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema'
      }
    end

    private

    def production?
      environment == 'production'
    end
  end
end
