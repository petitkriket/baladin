class NotifMailer < ApplicationMailer
  default from: "from@example.com"

  def sample_email(user, admin)
    @user = user
    mail(to: admin.email, subject: 'Nouvelle inscription sur Les Passageers')
  end

  def event_activation_email(user)
    @user = user
    mail(to: user.email, subject: 'Votre participation est en ligne')
  end

  def event_activation_previous_user_email(user)
    @user = user
    mail(to: user.email, subject: 'Des nouvelles de votre Passager')
  end
end
