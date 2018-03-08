RSpec.describe Siprelad::Person do
  before do
    Siprelad.configure do |config|
      config.user = "Administrador"
      config.password = "Siprelad_2017"
    end
  end
  let(:persona_select_response) { response_to_hash(file_fixture("persona_select_response.xml").read) }
  it "gets a person" do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(persona_select_response)
    person = Siprelad::Person.select({"Nombre" => "Mauricio"})
    puts person.inspect
    expect(person.rfc).to eq("MURGM890215")
  end

  it "inserts a person" do
    allow_any_instance_of(Siprelad::Requestor).to receive(:request).and_return(persona_select_response)
    person = Siprelad::Person.insert({"Nombre" => "Alejandro"})
    puts person.inspect
  end
end
