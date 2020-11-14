require 'rails_helper'
RSpec.describe Api::V1::SessionsController, type: :request do
  let(:user) { create(:user) }
  let(:signin_url) { '/api/v1/signin' }
  let(:signout_url) { '/api/v1/signout' }
  let(:user_attributes) { { user: { email: user.email, password: user.password } }.to_json }
  let(:invalid_user_attributes) { { user: { email: user.email, password: '' } }.to_json }
  let(:visitor_headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }

  context 'When sign in as an existing user' do
    before do
      post signin_url, headers: visitor_headers, params: user_attributes
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns an authentification header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(json['user']['email']).to eq(user.email)
    end
  end

  context 'When password is missing' do
    before do
      post signin_url, headers: visitor_headers, params: invalid_user_attributes
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end

  context 'When sign out as a signed user' do
    before do
      delete signout_url
    end

    it 'returns 200' do
      expect(response.status).to eq(204)
    end
  end
end
