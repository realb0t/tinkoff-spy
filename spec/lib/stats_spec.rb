require 'spec_helper'

describe Stats do

  let(:currency) { 'USD' }
  let(:represent) { subject.represent}
  subject { described_class.new(currency) }

  context "Without Rates" do

    it { -> { represent }.should_not raise_error }
    it { represent[:forecast].should == :indefinitely }

  end

  context "Current day is period" do

    before do
      create :rate, from: currency, parsed_at: Time.now.beginning_of_day
      create :rate, from: currency, parsed_at: Time.now
    end

    it { -> { represent }.should_not raise_error }
    it { represent.should be_present }
    it { represent[:forecast].should_not == :indefinitely }

  end

  context "Yesterday day is period" do

    before do
      create :rate, from: currency, parsed_at: Time.now.yesterday.beginning_of_day
      create :rate, from: currency, parsed_at: Time.now.yesterday.end_of_day
    end

    it { -> { represent }.should_not raise_error }
    it { represent.should be_present }
    it { represent[:forecast].should_not == :indefinitely }

  end

end