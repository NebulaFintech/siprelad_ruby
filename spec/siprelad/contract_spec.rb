RSpec.describe Siprelad::Contract do
  before do
    Siprelad.configure do |config|
      config.user = 'Administrador'
      config.password = 'lwi6Fk@7'
    end
  end
  let(:contrato_select_sofom_response) { response_to_hash(file_fixture('contrato_select_sofom_response.xml').read) }

  it 'gets a contract by id' do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(contrato_select_sofom_response)
    response_object = Siprelad::Contract.find(600)
    expect(response_object).to be_a(Siprelad::Contract)
    contract = response_object
    expect(contract.id).to eq(600)
  end
end
