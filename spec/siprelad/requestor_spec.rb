# frozen_string_literal: true

RSpec.describe Siprelad::Requestor do
  before do
    # This is needed because other tests may cause a configuration to be set.
    Siprelad.class_exec { @configuration = nil }
  end

  describe '#initialize' do
    context 'With configuration' do
      it 'fails if an user is not configured' do
        Siprelad.configure do |config|
        end

        expect do
          Siprelad::Requestor.new
        end.to raise_error('user has not been set!')
      end

      it 'fails if a password is not configured' do
        Siprelad.configure do |config|
          config.user = 'user'
        end

        expect do
          Siprelad::Requestor.new
        end.to raise_error('password has not been set!')
      end

      it 'fails if wsdl is not configured' do
        Siprelad.configure do |config|
          config.user = 'user'
          config.password = 'password'
        end

        expect do
          Siprelad::Requestor.new
        end.to raise_error('wsdl has not been set!')
      end

      it 'does not fail if everything is configured' do
        Siprelad.configure do |config|
          config.user = 'user'
          config.password = 'password'
          config.wsdl = 'https://www.example.com'
        end

        expect do
          Siprelad::Requestor.new
        end.to_not raise_error
      end
    end
  end
end
