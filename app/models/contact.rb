class Contact < MailForm::Base
  attribute :name, :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :user,   :validate => true
  attribute :nickname,  :captcha  => true

  def headers
    @user = User.find(self.user).email
    Rails.logger.debug("transmis model: #{@user}")

    {
      :subject => "Contact Form",
      :to => @user,
      :from => %("#{name}" <#{email}>)
    }
  end
end
