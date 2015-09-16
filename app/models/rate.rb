class Rate < ActiveRecord::Base
  validates :to, presence: true
  validates :from, presence: true
  validates :parsed_at, presence: true

  after_create :trigger_alert

  # Возвращает абсолютный спред
  #
  # @return [BigDecimal]
  def absolute_spread
    ask.to_d - bid
  end

  # Возвращает относительный спред
  # 
  # @return [BigDecimal]
  def comparative_spread
    absolute_spread / ask
  end

  protected

  # Вызывае срабатывание 
  # предустоновленных оповещений
  def trigger_alert
    Alert.by(self.from, 'sell', 'more', self.ask).map(&:trigger)
    Alert.by(self.from, 'sell', 'less', self.ask).map(&:trigger)
    Alert.by(self.from, 'buy', 'more', self.bid).map(&:trigger)
    Alert.by(self.from, 'buy', 'less', self.bid).map(&:trigger)
  end

end
