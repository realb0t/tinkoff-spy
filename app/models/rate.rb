class Rate < ActiveRecord::Base
  validates :to, presence: true
  validates :from, presence: true
  validates :parsed_at, presence: true
end
