# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::PassengersController, type: :request do
  let!(:passenger) { create(:passenger, :without_photo) }
  let!(:orphan_passenger) { create(:passenger, :without_photo) }
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let!(:event) { create(:event, passenger: passenger, user: user) }
  let(:valid_attributes) { { passenger: { name: 'Aldo' } } }
  let(:invalid_attributes) { { passenger: { name: '' } } }

  describe 'url helpers' do
    it { expect(api_v1_passengers_path).to eq('/api/v1/passengers') }
  end

  context 'as an unsigned user' do
    describe 'it can display passenger list' do
      before do
        get api_v1_passengers_path
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns passengers with published events only' do
        expect(JSON.parse(response.body).count).to eq 1
      end
    end

    describe 'returns a passenger' do
      before do
        get api_v1_passenger_path(passenger.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    describe 'cannot edit a passenger' do
      context 'with valid params' do
        before do
          put api_v1_passenger_path(passenger.id), params: { passenger: valid_attributes }
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end
  end

  context 'as a signed user' do
    describe 'cannot edit a passenger' do
      context 'with valid params' do
        before do
          login_with_api(user)
          put api_v1_passenger_path(passenger.id), params: { passenger: valid_attributes }
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end

        after do
          logout_with_api(user)
        end
      end
    end
  end

  context 'as a admin user' do
    describe 'can edit a passenger' do
      context 'with valid params' do
        before do
          login_with_api(admin)
          put api_v1_passenger_path(passenger.id), params: valid_attributes
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        after do
          logout_with_api(admin)
        end
      end
      context 'with invalid params' do
        before do
          login_with_api(admin)
          put api_v1_passenger_path(passenger.id), params: invalid_attributes
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        after do
          logout_with_api(admin)
        end
      end
    end
  end
end
