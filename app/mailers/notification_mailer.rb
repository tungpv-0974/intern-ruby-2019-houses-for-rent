class NotificationMailer < ApplicationMailer
  def notification_email email, url
    @url = url
    @email = email
    mail to: email, subject: t(".new_notification")
  end
end
