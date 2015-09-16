require 'spec_helper'

describe Stats do

  let(:currency) { 'USD' }
  subject { described_class.new(currency) }

  context "Without Rates" do

    it { -> { subject.represent }.should_not raise_error }

  end

  context "Current day is period" do

    before do
      create :rate, from: currency, parsed_at: Time.now.beginning_of_day
      create :rate, from: currency, parsed_at: Time.now
    end

    it { -> { subject.represent }.should_not raise_error }
    it { subject.represent.should be_present }

  end

  context "Yesterday day is period" do

    before do
      create :rate, from: currency, parsed_at: Time.now.yesterday.beginning_of_day
      create :rate, from: currency, parsed_at: Time.now.yesterday.end_of_day
    end

    it { -> { subject.represent }.should_not raise_error }
    it { subject.represent.should be_present }

  end

end