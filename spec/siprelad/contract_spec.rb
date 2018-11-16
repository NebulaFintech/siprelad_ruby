RSpec.describe Siprelad::Contract do
  before do
    Siprelad.configure do |config|
      config.user = 'Administrador'
      config.password = 'lwi6Fk@7'
    end
  end
  let(:contrato_select_sofom_response) { response_to_hash(file_fixture('contrato_select_sofom_response.xml').read) }
  let(:contrato_insert_sofom_response) { response_to_hash(file_fixture('contrato_insert_sofom_response.xml').read) }

  it 'gets a contract by id' do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(contrato_select_sofom_response)
    response_object = Siprelad::Contract.find(600)
    expect(response_object).to be_a(Siprelad::Contract)
    contract = response_object
    expect(contract.id).to eq(600)
  end

  it 'creates a contract' do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(contrato_insert_sofom_response)
    expect{ 
      Siprelad::Contract.create(
        id: 1,
        customer_id: 1,
        expected_disbursement_at: Date.parse('15-05-2017'),
        monthly_income: 15_000,
        months_duration: 12,
        monthly_repayment: 780,
        liquidation_date: Date.parse('15-05-2018'),
        currency: :mxn,
        principal: 10_000
      )}.to_not raise_error
  end
end
