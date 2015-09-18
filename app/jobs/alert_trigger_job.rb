class AlertTriggerJob < ActiveJob::Base
  queue_as :default

  def perform(currency, ask, bid)
    ( Alert.by(currency, 'sell', 'more', ask) +
      Alert.by(currency, 'sell', 'less', ask) +
      Alert.by(currency, 'buy', 'more', bid) +
      Alert.by(currency, 'buy', 'less', bid) ).map(&:trigger)
  end
end
