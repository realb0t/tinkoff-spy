require 'spec_helper'

describe Parser::Tinkoff do

  subject { described_class.new }

  context "API is avalible", vcr: { cassette_name: "tinkoff_ok", record: :once } do

    it "should be get data from remote service" do
      subject.data.should == { 
        USD: {
          RUB: { ask: 69.05, bid: 66.35}, 
          EUR: { ask: 0.9009009009, bid: 0.8620689655}
        }, 
        EUR: {
          RUB: { ask: 78.25, bid: 75.2}, 
          USD: { ask: 1.16, bid: 1.11}
        }
      }
    end

  end

  context "API is not avalible with 401 state", vcr: { cassette_name: "tinkoff_401" } do

    it "raise error" do
      -> { subject.data }.should raise_error(Parser::Error)
    end

  end


  context "API is not avalible with empty body", vcr: { cassette_name: "tinkoff_empty" } do

    it "raise error" do
      -> { subject.data }.should raise_error(Parser::Error)
    end

  end
end
