require 'spec_helper'

describe Stats do

  let(:currency) { 'USD' }
  subject { described_class.new(currency) }

  context "Current day is period" do

    before do
      create :rate, from: currency, parsed_at: Time.now.beginning_of_day
      create :rate, from: currency, parsed_at: Time.now
    end

    it { -> { subject.represent }.should_not raise_error }
    it { subject.represent.should be_present }

  end

end