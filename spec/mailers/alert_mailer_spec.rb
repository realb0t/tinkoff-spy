require "rails_helper"

RSpec.describe AlertMailer, type: :mailer do
  describe 'alert_mail' do
    let(:alert) { build(:alert) }
    let(:mail) { described_class.trigger_mail(alert) }
  
    it 'renders the receiver email' do
      (mail.to).should include(alert.email)
    end

    it 'assigns @alert into HTML' do
      mail.body.encoded.should match(alert.currency)
      mail.body.encoded.should match(alert.value.to_s)
    end
  end
end
