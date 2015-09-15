class AlertMailer < ApplicationMailer

  def trigger_mail(alert)
    @alert = alert
    mail(to: @alert.email, subject: I18n.t('mailer.alert.subject'))
  end

end
