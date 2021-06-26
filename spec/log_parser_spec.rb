# frozen_string_literal: true

require 'rspec'
require 'log_parser'

describe LogParser do
  before(:each) do
    @log_parser = LogParser.new('data/test_data.log')
  end

  it 'parses the file it is given' do
    expect(@log_parser).to respond_to(:parse)
  end

  it 'returns a hash of ordered page visits' do
    parsed_logs = @log_parser.parse
    keys = ['/home', '/contact/', '/about', '/products/3']
    values = [['225.183.113.22', '225.183.113.22'], ['245.141.61.189', '61.64.28.106'],
              ['122.255.244.161', '138.222.28.220', '228.32.104.207'], ['138.222.28.220']]
    expect(parsed_logs).to be_a(Hash)
    expect(parsed_logs.keys).to eq(keys)
    expect(parsed_logs.values).to eq(values)
  end
end
