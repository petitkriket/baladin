class NotifMailer < ApplicationMailer
  default from: "from@example.com"

  def registration_email(user, admin)
    @user = user
    #mail(to: admin.email, subject: I18n.t('notif_mailer.registration_email.subject'))
    I18n.with_locale(admin.locale) do
    mail(
     to: admin.email,
     subject: I18n.t('notif_mailer.registration_email.subject')
   )
 end
  end

  def event_activation_email(user, passenger, event)
    @user = user
    @passenger = passenger
    @event = event
    #mail(to: user.email, subject: I18n.t('notif_mailer.event_activation_email.subject'))
    I18n.with_locale(@user.locale) do
    mail(
     to: user.email,
     subject: I18n.t('notif_mailer.event_activation_email.subject')
   )
 end
  end

  def event_activation_previous_user_email(user, passenger, event)
    @user = user
    @passenger = passenger
    @event = event
    #mail(to: user.email, subject: I18n.t('notif_mailer.event_activation_previous_user_email.subject', passenger_name: @passenger.name))
    I18n.with_locale(@user.locale) do
    mail(
     to: user.email,
     subject: I18n.t('notif_mailer.event_activation_previous_user_email.subject', passenger_name: @passenger.name)
   )
 end
  end
end
