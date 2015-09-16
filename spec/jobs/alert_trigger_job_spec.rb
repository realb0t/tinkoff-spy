require 'rails_helper'

RSpec.describe AlertTriggerJob, type: :job do
  context "if alerts exists" do
    let!(:sell_alert) { create(:alert, { currency: 'USD', value: 4, deal_type: 'sell', sign: 'less' }) }
    let!(:buy_alert) { create(:alert, { currency: 'USD', value: 2, deal_type: 'buy', sign: 'more' }) }
    let!(:buy_alert) { create(:alert, { currency: 'USD', value: 5, deal_type: 'buy', sign: 'less' }) }
    let!(:sell_alert) { create(:alert, { currency: 'USD', value: 1, deal_type: 'sell', sign: 'more' }) }

    it "sends trigger emails" do
      described_class.perform_now('USD', 5, 1)
      ActionMailer::Base.deliveries.count.should == 2
    end
  end
end
