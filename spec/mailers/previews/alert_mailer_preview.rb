# Preview all emails at http://localhost:3000/rails/mailers/alert_mailer
class AlertMailerPreview < ActionMailer::Preview

  def trigger_mail
    alert = Alert.first
    alert ||= FactoryGirl.create(:alert)
    AlertMailer.trigger_mail(alert)
  end

end
