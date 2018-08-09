# Preview all emails at http://localhost:3000/rails/mailers/notif_mailer
class NotifMailerPreview < ActionMailer::Preview
  def registration_mail_preview
    NotifMailer.registration_email(User.first, User.last)
  end

  def event_activation_mail_preview
    NotifMailer.event_activation_email(User.first, Passenger.first, Event.last)
  end

  def event_previous_mail_preview
    NotifMailer.event_activation_previous_user_email(User.last, Passenger.first, Event.last)
  end
end
