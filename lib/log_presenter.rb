# frozen_string_literal: true

# Gets parsed logs and returns presented logs
class LogPresenter
  def initialize(parsed_logs)
    @parsed_logs = parsed_logs
  end

  def presented_logs
    [ordered_views, "\n", unique_views]
  end

  private

  def ordered_views
    visits = {}
    @parsed_logs.each { |page, ip| visits[page] = ip.size }
    sorted_visits = visits.sort_by { |_, ip| ip }.reverse
    presented_logs = []
    sorted_visits.each do |visit|
      qualifier = visit[1] == 1 ? 'visit' : 'visits'
      presented_logs << constructor(visit[0], visit[1], qualifier)
    end
    presented_logs
  end

  def unique_views
    @parsed_logs.each { |page, ips| @parsed_logs[page] = ips.uniq.size }
    sorted_visits = @parsed_logs.sort_by { |_, views| views }.reverse
    presented_logs = []
    sorted_visits.each do |visit|
      qualifier = visit[1] == 1 ? 'unique view' : 'unique views'
      presented_logs << constructor(visit[0], visit[1], qualifier)
    end
    presented_logs
  end

  def constructor(page, number, qualifier)
    "#{page} #{number} #{qualifier}"
  end
end
