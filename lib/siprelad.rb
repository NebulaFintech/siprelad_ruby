require 'siprelad/version'
require 'siprelad/mixins/select'
require 'siprelad/mixins/insert'
require 'siprelad/resource'
require 'siprelad/person'
require 'siprelad/requestor'
require 'siprelad/configuration'
require 'savon'
require 'savon_logger_helper'
module Siprelad
  require 'active_support'
  require 'active_support/core_ext'

  def self.configure
    yield(configuration)
    set_connection(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  private

  def self.set_connection(configuration)
    configuration.connection = Savon.client(
      wsdl: configuration.wsdl,
      open_timeout: configuration.open_timeout,
      read_timeout: configuration.read_timeout,
      env_namespace: 'soap',
      namespaces: configuration.namespaces,
      element_form_default: :qualified
    )
  end
end
