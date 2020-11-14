# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Api::V1::EventsController, type: :request do
  let!(:user) { create(:user) }
  let!(:passenger) { create(:passenger, :without_photo) }
  let!(:event) { create(:event, passenger: passenger, user: user) }
  let(:event_url) { '/api/v1/events' }

  let!(:second_user) { create(:user) }
  let!(:second_event) { create(:event, passenger: passenger, user: second_user) }

  let!(:third_use) { create(:user) }
  let!(:third_user) { create(:event, :pending, passenger: passenger, user: third_use) }

  let!(:second_passenger) { create(:passenger, :without_photo) }
  let(:valid_attributes) do
    {
      event: { photo: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/event.jpg") }
    }
  end

  let(:invalid_attributes) { { event: { name: '' } } }
  let(:unpermitted_attributes) do
    {
      event: { passenger_id: 1, user: 1, address: 'none', country: 'JP', published: false, latitude: 0, longitude: 0 }
    }
  end

  let(:event_creation) do
    {
      event: { photo: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/event.jpg"), address: '36 Baladins st.' },
      passenger: { shortcut: second_passenger.shortcut },
      user: { email: user.email }
    }
  end

  let(:event_creation_no_photo) do
    {
      event: { address: '36 Baladins st.' },
      passenger: { shortcut: second_passenger.shortcut },
      user: { email: user.email }
    }
  end

  let(:event_creation_invalid) do
    {
      event: { address: '36 Baladins st.' },
      passenger: { shortcut: 'BLAH' },
      user: { email: user.email }
    }
  end
  describe 'url helpers' do
    it { expect(api_v1_passenger_events_path(passenger.id)).to eq("/api/v1/passengers/#{passenger.id}/events") }
  end

  context 'as an unsigned user' do
    describe 'it displays a passenger event list' do
      before do
        get api_v1_passenger_events_path(passenger.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    describe 'it displays published passenger events' do
      before do
        get api_v1_passenger_events_path(passenger.id)
      end

      it 'it returns published events only' do
        expect(JSON.parse(response.body).count).to eq 2
      end
    end

    describe 'it displays an event' do
      before do
        get api_v1_passenger_events_path(passenger.id, event.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    describe 'it cannot edit an event' do
      context 'with valid params' do
        before do
          put api_v1_passenger_event_path(passenger.id, event.id), params: valid_attributes
        end

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end
      end
    end

    describe 'it creates an event' do
      context 'with valid params' do
        before do
          post event_url, params: event_creation
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
          # expect(json['event']['passenger_id']).to eq(second_passenger.id)
          expect(json['event']['user']['name']).to eq(user.name)
        end
      end

      context 'with valid params but no picture' do
        before do
          post event_url, params: event_creation_no_photo
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
          # expect(json['event']['passenger_id']).to eq(second_passenger.id)
          expect(json['event']['user']['name']).to eq(user.name)
        end
      end

      context 'with invalid params' do
        before do
          post event_url, params: event_creation_invalid
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end

      context 'with already existing history' do
        before do
          event = create(:event, passenger: second_passenger, user: user)
          event.save
          post event_url, params: event_creation
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  context 'as a signed user' do
    describe 'it can edit an event' do
      context 'with valid params' do
        before do
          login_with_api(user)
          put api_v1_passenger_event_path(passenger.id, event.id), params: valid_attributes
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        after do
          logout_with_api(user)
        end
      end

      context 'with invalid params' do
        before do
          login_with_api(user)
          put api_v1_passenger_event_path(passenger.id, event.id), params: invalid_attributes
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        after do
          logout_with_api(user)
        end
      end

      context 'with unpermitted params' do
        before do
          login_with_api(user)
          put api_v1_passenger_event_path(passenger.id, event.id), params: unpermitted_attributes
        end

        it 'returns an unchanged object' do
          expect(json['event']['country']).to eq(event.country)
          expect(json['event']['latitude']).to eq(event.latitude)
          expect(json['event']['longitude']).to eq(event.longitude)
        end

        after do
          logout_with_api(user)
        end
      end
    end

    describe 'it creates an event' do
      context 'with valid params' do
        before do
          login_with_api(second_user)
          post event_url, params: event_creation
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
          # expect(json['event']['passenger_id']).to eq(second_passenger.id)
          expect(json['event']['user']['name']).to eq(second_user.name)
        end

        after do
          logout_with_api(second_user)
        end
      end

      context 'with invalid params' do
        before do
          login_with_api(second_user)
          post event_url, params: event_creation_invalid
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        after do
          logout_with_api(second_user)
        end
      end

      context 'with existing history' do
        before do
          event = create(:event, passenger: second_passenger, user: user)
          event.save
          login_with_api(user)
          post event_url, params: event_creation
        end

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        after do
          logout_with_api(user)
        end
      end
    end
  end
end
