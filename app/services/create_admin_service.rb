class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.credentials.dig(:superuser_email)) do |user|
      user.password = Rails.application.credentials.dig(:superuser_password)
      user.password_confirmation = Rails.application.credentials.dig(:superuser_password)
      user.confirm
      user.admin!
    end
  end
end
