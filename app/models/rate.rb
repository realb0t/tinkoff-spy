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
    AlertTriggerJob.perform_later(from, ask, bid)
  end

end
