# frozen_string_literal: true

require 'rspec'
require 'log_parser'
require 'log_presenter'

RSpec.describe LogPresenter do
  before(:each) do
    @parsed_file = LogParser.new('data/test_data.log').parse
    @log_presenter = LogPresenter.new(@parsed_file)
  end

  it 'parses the file it is given' do
    expect(@log_presenter).to respond_to(:presented_logs)
  end

  it 'returns a list of webpages in descending order of views' do
    result = @log_presenter.send(:ordered_views)
    expected = ['/about 3 visits', '/contact/ 2 visits', '/home 2 visits', '/products/3 1 visit']
    expect(result).to match(expected)
  end

  it 'returns a list of webpages with most unique page views also ordered' do
    expected = ['/about 3 unique views', '/contact/ 2 unique views', '/products/3 1 unique view', '/home 1 unique view']
    result = @log_presenter.send(:unique_views)
    expect(result).to match(expected)
  end
end
