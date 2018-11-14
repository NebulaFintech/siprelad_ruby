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
    response_objects = Siprelad::Person.find(1)
    expect(response_objects).to be_a(Array)
    expect(response_objects.size).to eq(1)
    person = response_objects.first
    expect(person).to be_a(Siprelad::Person)
    expect(person.rfc).to eq('BAGD851003SA7')
  end

  # it 'inserts a person' do
  #   allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(persona_insert_response)
  #   person = Siprelad::Person.insert('Nombre' => 'Alejandro')
  #   puts person.inspect
  # end
end
