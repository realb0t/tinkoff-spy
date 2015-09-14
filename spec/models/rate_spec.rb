require 'rails_helper'

RSpec.describe Rate, type: :model do
  subject { FactoryGirl.build(:rate) }

  it { should have_db_column(:from).of_type(:string).with_options(null: false) }
  it { should have_db_column(:to).of_type(:string).with_options(null: false) }
  it { should have_db_column(:ask).of_type(:float).with_options(null: false, default: 0.0, unsign: true) }
  it { should have_db_column(:bid).of_type(:float).with_options(null: false, default: 0.0, unsign: true) }
  it { should have_db_column(:parsed_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_index(:from) }
  it { should have_db_index(:to) }
  it { should have_db_index(:parsed_at) }

  it { should validate_presence_of(:parsed_at) }
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:from) }
end
