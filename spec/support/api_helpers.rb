# frozen_string_literal: true

module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def login_with_api(user)
    post '/api/v1/signin',
         params: { user: { email: user.email, password: user.password } }.to_json,
         headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  end

  def logout_with_api(user)
    delete '/api/v1/signout'
  end
end
