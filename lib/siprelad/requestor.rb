module Siprelad
  class Requestor
    attr_reader :user, :password, :connection
    def initialize
      @user = Siprelad.configuration.user
      @password = Siprelad.configuration.password
      @connection = Siprelad.configuration.connection
      fail "User has not been set!" if @user.blank?
      fail "password has not been set!" if @password.blank?
    end

    def request(operation, params={})
      response = connection.call(operation, message: authentication.merge(params))
      response.body
    end

    private

      def authentication
        { 'Usuario' => Siprelad.configuration.user, 'Contrasena' => Siprelad.configuration.password }
      end
  end
end