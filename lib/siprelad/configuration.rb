module Siprelad
  class Configuration
    attr_accessor :environment, :wsdl, :connection, :open_timeout, :read_timeout,
                  :user, :password

    def initialize
      @open_timeout = 5
      @read_timeout = 5
      @environment = ENV['RAILS_ENV']
      @wsdl = 'http://internal-elb-shared-priv-pld-1296134306.us-east-1.elb.amazonaws.com/WCF_PLD/Service.svc?wsdl'
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
