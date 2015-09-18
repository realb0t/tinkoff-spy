class LoadRatesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    parser = ::Parser::Tinkoff.new
    fabric = ::RemoteRates.new(parser)
    rates  = fabric.factory
    Rails.cache.delete(:rates_current_stats) if rates.present?
    Rate.transaction { rates.map(&:save!) }
  end
end
