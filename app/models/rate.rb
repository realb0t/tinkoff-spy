class Rate < ActiveRecord::Base
  validates :to, presence: true
  validates :from, presence: true
  validates :parsed_at, presence: true

  after_create :trigger_alert

  protected

  def trigger_alert
    alerts = []
    alerts += Alert.by(self.from, 'sell', 'more', self.ask)
    alerts += Alert.by(self.from, 'sell', 'less', self.ask)
    alerts += Alert.by(self.from, 'buy', 'more', self.bid)
    alerts += Alert.by(self.from, 'buy', 'less', self.bid)
    alerts.map(&:trigger)
  end

end
