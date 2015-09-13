require 'spec_helper'

describe Parser::Tinkoff do

  context "Get data", vcr: { cassette_name: "bitstamp.public_api", record: :once } do

    it "should be get data from remote service" do
      lambda { 
        Parser::Tinkoff.new.data
      }.should_not raise_error
    end

  end

end