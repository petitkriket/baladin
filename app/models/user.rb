class User < ApplicationRecord
  enum role: %i[user vip admin]
  after_initialize :set_default_role, if: :new_record?
  has_many :events, dependent: :nullify
  accepts_nested_attributes_for :events

  def set_default_role
    self.role ||= :user
  end

  def send_devise_notification(notification, *args)
    I18n.with_locale(locale) { super(notification, *args) }
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
end
