class Contact < MailForm::Base
  attribute :name, :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :user,   :validate => true
  attribute :nickname,  :captcha  => true

  def headers
    Rails.logger.debug("nom fourni: #{self.name}")
    Rails.logger.debug("email fourni: #{self.email}")
    Rails.logger.debug("message: #{self.message}")
    Rails.logger.debug("Email destination: #{self.user}")

    {
      :subject => "Contact Form",
      :to => self.user,
      :from => %("#{name}" <#{email}>)
    }
  end
end
