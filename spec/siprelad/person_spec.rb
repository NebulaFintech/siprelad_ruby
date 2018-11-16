RSpec.describe Siprelad::Person do
  before do
    Siprelad.configure do |config|
      config.user = 'Administrador'
      config.password = 'lwi6Fk@7'
    end
  end
  let(:persona_select_response) { response_to_hash(file_fixture('persona_select_response.xml').read) }
  let(:personas_select_response) { response_to_hash(file_fixture('personas_select_response.xml').read) }
  let(:persona_select_id_response) { response_to_hash(file_fixture('persona_select_id_response.xml').read) }
  let(:persona_insert_error_response) { response_to_hash(file_fixture('persona_insert_error_response.xml').read) }

  it 'gets a single person' do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(persona_select_response)
    response_objects = Siprelad::Person.where(given_names: 'David')
    expect(response_objects).to be_a(Array)
    expect(response_objects.size).to eq(1)
    person = response_objects.first
    expect(person).to be_a(Siprelad::Person)
    expect(person.rfc).to eq('BAGD851003SA7')
  end

  it 'gets multiple persons' do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(personas_select_response)
    response_objects = Siprelad::Person.where(given_names: 'JAIME')
    person = response_objects.first
    expect(response_objects).to be_a(Array)
    expect(response_objects.size).to eq(2)
    expect(person).to be_a(Siprelad::Person)
    expect(person.codigo_postal).to eq('12132')
  end

  it 'gets a person by id' do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(persona_select_id_response)
    response_object = Siprelad::Person.find(1)
    expect(response_object).to be_a(Siprelad::Person)
    person = response_object
    expect(person.rfc).to eq('BAGD851003SA7')
  end

  it 'inserts a person and fails' do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(persona_insert_error_response)
    expect{
      Siprelad::Person.create(
        id: 1,
        given_names: 'Mauricio Fernando',
        paternal_surname: 'Murga',
        mothers_maiden_name: 'González',
        rfc: 'MUGM8902152V4',
        curp: 'MUGM890215HNLRNR06',
        birth_date: Date.parse('15-02-1989'),
        street1: 'Río Támesis',
        external_number: '114',
        neighborhood: 'Roma',
        municipality_pld_id: '02340009',
        state_pld_id: '9',
        postal_code: '64700',
        country: 'MX',
        mobile_phone: '8186567150',
        starting_working_date: Date.parse('15-08-2017'),
        economic_activity_code: '8200008',
        gender: 'male',
        country_of_birth: 'MX',
        fea_reference_id: '1234567890',
        province_of_birth_pld_id: '9',
        email: 'mauricio.murga@gonebula.io',
        civil_status: 'married',
        housing_type: 'owned',
        lived_in_since: Date.parse('15-02-1989'))}.to raise_error(RuntimeError, ' / APaterno es requerido')
  end
end
