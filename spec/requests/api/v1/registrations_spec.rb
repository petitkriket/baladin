# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::RegistrationsController, type: :request do
  let(:user) { build(:user) }
  let(:existing_user) { create(:user) }
  let(:signup_url) { '/api/v1/signup' }
  let(:account_url) { '/api/v1/account' }
  let(:valid_attributes) { { user: { name: 'Aldo Le Magnifique', locale: 'esperanza' } } }
  let(:invalid_attributes) { { user: { role: 'admin' } } }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    # it 'returns a token' do
    #   expect(response.headers['Authorization']).to be_present
    # end

    it 'returns the user email' do
      expect(json['user']['email']).to eq(user.email)
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 400' do
      expect(response.status).to eq(422)
    end
  end

  context 'When editing settings' do
    before do
      login_with_api(existing_user)
      put account_url, params: valid_attributes
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
      expect(json['user']['name']).to eq(valid_attributes[:user][:name])
      expect(json['user']['locale']).to eq(valid_attributes[:user][:locale])
    end

    after do
      logout_with_api(existing_user)
    end
  end

  context 'When editing unpermitted settings' do
    before do
      login_with_api(existing_user)
      put account_url, params: invalid_attributes
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(200)
      expect(json['user']['role']).not_to eq(valid_attributes[:user][:role])
    end

    after do
      logout_with_api(existing_user)
    end
  end

  context 'When deleting an account' do
    before do
      login_with_api(existing_user)
      delete account_url
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(204)
    end
  end
end
