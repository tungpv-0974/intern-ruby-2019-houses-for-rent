class NotificationEmailWorker
  include Sidekiq::Worker

  def perform email, url
    NotificationMailer.notification_email(email, url).deliver
  end
end
