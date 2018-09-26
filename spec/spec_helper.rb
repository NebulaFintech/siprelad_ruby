require 'bundler/setup'
require 'siprelad'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def file_fixture(fixture_name)
  file_fixture_path = 'spec/fixtures'
  path = Pathname.new(File.join(file_fixture_path, fixture_name))

  if path.exist?
    path
  else
    msg = "the directory '%s' does not contain a file named '%s'"
    raise ArgumentError, format(msg, file_fixture_path, fixture_name)
  end
end

def response_to_hash(response)
  nori = Nori.new(strip_namespaces: true, convert_tags_to: ->(tag) { tag.snakecase.to_sym })
  hash = nori.parse(response)
  envelope = nori.find(hash, 'Envelope')
  nori.find(envelope, 'Body')
end
