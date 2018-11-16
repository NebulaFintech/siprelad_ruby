module Siprelad
  class Configuration
    attr_accessor :environment, :wsdl, :connection, :open_timeout, :read_timeout,
                  :user, :password

    def initialize
      @open_timeout = 5
      @read_timeout = 5
      @environment = ENV['RAILS_ENV']
      @wsdl = (production? ? 'http://internal-elb-shared-priv-pld-1296134306.us-east-1.elb.amazonaws.com/WCF_PLD/ServicePLD.svc?singleWsdl' :
                             'https://pld.gonebula.io/WCF_PLD/ServicePLD.svc?singleWsdl')
    end

    def namespaces
      {
        'xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/',
        'xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema',
        'xmlns:tem' => 'http://tempuri.org/'
      }
    end

    private

    def production?
      environment == 'production'
    end
  end
end
