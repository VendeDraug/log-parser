# frozen_string_literal: true

# Gets raw logs from Parser and returns { page: [ips] }
class LogParser
  def initialize(src_file)
    @src_file = src_file
  end

  def parse
    parse_logs
  end

  private

  def parse_logs
    log_file = File.open(@src_file)
    log_file.each_with_object({}) do |row, logs_hash|
      page, ip = row.split(' ')
      logs_hash.key?(page) ? logs_hash[page] << ip : logs_hash[page] = [ip]
    end
  end
end
