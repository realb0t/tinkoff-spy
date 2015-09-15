class Alert < ActiveRecord::Base
  validates :currency, presence: true, inclusion: { in: %w(EUR USD) }
  validates :deal_type, presence: true, inclusion: { in: %w(buy sell) }
  validates :sign, presence: true, inclusion: { in: %w(more less) }
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  scope :by_value, -> (sig, val) { 
    where(((sig == 'more') ? 'value < ?' : 'value > ?'), val) 
  }

  scope :by, -> (cur, deal, sig, val) { 
    where(deal_type: deal, currency: cur, sign: sig).by_value(sig, val)
  }

  def trigger
    AlertMailer.trigger_mail(self).deliver_now
  end

end
