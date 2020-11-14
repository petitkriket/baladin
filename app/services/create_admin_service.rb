# frozen_string_literal: true

class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.credentials.dig(:superuser_email)) do |user|
      user.password = Rails.application.credentials.dig(:superuser_password)
      user.password_confirmation = Rails.application.credentials.dig(:superuser_password)
      user.confirm
      user.admin!
    end
  end

  def dev
    user = User.find_or_create_by!(email: 'admin@example.com') do |user|
      user.password = 'Password123!'
      user.password_confirmation = 'Password123!'
      user.confirm
      user.admin!
    end
  end
end
