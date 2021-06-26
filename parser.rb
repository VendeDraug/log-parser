# frozen_string_literal: true

require_relative 'lib/log_parser'
require_relative 'lib/log_presenter'

VALID_FILE_TYPE = /.log\z/.freeze

# Initial class that calls the relevant log parser and presentes results
class Parser
  if __FILE__ == $PROGRAM_NAME
    if ARGV.length.zero?
      puts 'Please select a file to parse.'
    elsif ARGV.length == 1
      if ARGV[0].match?(VALID_FILE_TYPE)
        parsed_logs = LogParser.new(ARGV[0]).parse
        presented_logs = LogPresenter.new(parsed_logs).presented_logs
        puts presented_logs
      else
        puts 'Please select a valid log file.'
      end
    else
      puts 'Multiple files are not yet supported.'
    end
  end
end
