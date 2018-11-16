RSpec.describe Siprelad::Operation do
  before do
    Siprelad.configure do |config|
      config.user = 'Administrador'
      config.password = 'lwi6Fk@7'
    end
  end

  let(:operacion_insert_sofom_error_response) { response_to_hash(file_fixture('operacion_insert_sofom_error_response.xml').read) }

  it 'creates an operation' do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(operacion_insert_sofom_error_response)
    expect{ 
      Siprelad::Operation.create(
        id: 1,
        customer_id: 1,
        loan_product_id: 1,
        contract_id: 1,
        operation_date: Date.parse('15-06-2017'),
        operation_amount: 780,
        currency: :mxn,
        loan_balance: 9_220
      )}.to raise_error(RuntimeError, ' /NoDeCliente(Persona) es requerido /IdAuxiliar(Contrato) no existe para el NoDeCliente(Persona) /IdOrigenOperacion es requerido')
  end
end
