class AlertTriggerJob < ActiveJob::Base
  queue_as :default

  def perform(currency, ask, bid)
    Alert.by(currency, 'sell', 'more', ask).map(&:trigger)
    Alert.by(currency, 'sell', 'less', ask).map(&:trigger)
    Alert.by(currency, 'buy', 'more', bid).map(&:trigger)
    Alert.by(currency, 'buy', 'less', bid).map(&:trigger)
  end
end
