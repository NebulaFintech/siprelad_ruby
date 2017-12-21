require "siprelad/version"
require "siprelad/mixins/select"
require "siprelad/resource"
require "siprelad/person"
require "siprelad/requestor"
module Siprelad
  require 'active_support'
  require 'active_support/core_ext'

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    require 'savon'
    WSDL = 'http://54.156.192.102/WCF_PLD/Service.svc?wsdl'
    attr_accessor :open_timeout, :read_timeout, :user, :password, :connection

    def initialize
      @open_timeout = 5
      @read_timeout = 5
      @user = nil
      @password = nil
      @connection = Savon.client(wsdl: WSDL, open_timeout: @open_timeout, read_timeout: @read_timeout, element_form_default: :qualified)
    end
  end
end