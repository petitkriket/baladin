class Contact < MailForm::Base
  attribute :name, validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   validate: true
  attribute :user, validate: true
  attribute :nickname, captcha: true

  def headers
    {
      subject: I18n.t('reach_passenger_holder'),
      to: user,
      from: %("#{name}" <#{email}>)
    }
  end
end
