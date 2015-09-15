require 'rails_helper'

RSpec.describe LoadRatesJob, type: :job do

  context "API is avalible", vcr: { cassette_name: "tinkoff_ok", record: :once } do

    it "should be get data from remote service" do
      Rate.should_not be_exist
      described_class.perform_now
      Rate.should be_exist
    end

  end

  context "API is NOT avalible", vcr: { cassette_name: "tinkoff_empty", record: :once } do

    it "should be get data from remote service" do
      Rate.should_not be_exist
      described_class.perform_now
      Rate.should_not be_exist
    end

  end

end
