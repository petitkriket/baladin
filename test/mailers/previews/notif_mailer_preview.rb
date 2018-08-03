# Preview all emails at http://localhost:3000/rails/mailers/notif_mailer
class NotifMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    NotifMailer.sample_email(User.first, User.last)
  end

  def event_activation_mail_preview
    NotifMailer.event_activation_email(User.first)
  end

  def event_previous_mail_preview
    NotifMailer.event_activation_previous_user_email(User.last)
  end
end
