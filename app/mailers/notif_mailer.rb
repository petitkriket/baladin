class NotifMailer < ApplicationMailer
  default from: 'no-reply@' + Rails.application.credentials.dig(:domain_name_short),
          reply_to: 'contact@' + Rails.application.credentials.dig(:domain_name_short)

  # an email to notify an administrator that a new user has registered an artwork
  def registration_email(user, admin)
    @user = user
    I18n.with_locale(admin.locale) do
      mail(
        to: admin.email,
        subject: I18n.t('notif_mailer.registration_email.subject')
      )
    end
  end

    # an email to notify the new owner that contribution has been activated by site a administrator
  def event_activation_email(user, passenger, event)
    @user = user
    @passenger = passenger
    @event = event

    I18n.with_locale(@user.locale) do
      mail(
        to: user.email,
        subject: I18n.t('notif_mailer.event_activation_email.subject')
      )
    end
  end

  # an email to notify the user that previously owneed artwork has been activated by a following user
  def event_activation_previous_user_email(user, passenger, event)
    @user = user
    @passenger = passenger
    @event = event

    I18n.with_locale(@user.locale) do
      mail(
        to: user.email,
        subject: I18n.t('notif_mailer.event_activation_previous_user_email.subject', passenger_name: @passenger.name)
      )
    end
  end
end
