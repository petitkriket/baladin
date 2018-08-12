class Contact < MailForm::Base
  attribute :name, :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :user,   :validate => true
  attribute :nickname,  :captcha  => true

  def headers


    Rails.logger.debug("transmis model: #{@user}")
    Rails.logger.debug("transmis model: #{@event}")
    Rails.logger.debug("transmis model: #{self.user}")
    {
      :subject => "Contact Form",
      :to => self.user,
      :from => %("#{name}" <#{email}>)
    }
  end
end
