class Alert < ActiveRecord::Base
  validates :currency, presence: true, inclusion: { in: %w(EUR USD) }
  validates :deal_type, presence: true, inclusion: { in: %w(buy sell) }
  validates :sign, presence: true, inclusion: { in: %w(more less) }
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
