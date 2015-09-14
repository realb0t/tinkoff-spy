require 'spec_helper'

describe RemoteRates do

  subject { described_class.new(parser) }
  let(:parser) { Parser::Tinkoff.new }
  let(:result) { subject.factory }

  context "API is avalible" do

    before do
      RR.mock(parser).data {
        { USD: { RUB: { ask: 69.05, bid: 66.35}, EUR: { ask: 0.9009009009, bid: 0.8620689655} }, 
          EUR: { RUB: { ask: 78.25, bid: 75.2},  USD: { ask: 1.16, bid: 1.11} } }
      }
    end

    it "result should be return Rates array with 2 objects" do
      result.size.should == 2
    end

    it "result should be a kind of Rates" do
      result.map { |rate| rate.should be_a_kind_of(Rate) }
    end

    it "result should be new record" do
      result.map { |rate| rate.should be_new_record }
    end

  end

  context "API is NOT avalible" do

    before do
      RR.mock(parser).data {
        raise Parser::Error.new(parser), 'Tinkoff API not avalible'
      }
    end

    it "should be return empty data" do
      result.should be_empty
    end

  end

end