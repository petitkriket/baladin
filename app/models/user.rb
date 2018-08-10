class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events
  def set_default_role
    self.role ||= :user
  end

  def send_devise_notification(notification, *args)
    I18n.with_locale(self.locale) { super(notification, *args) }
  end
  
  private #ajout du private ??


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
