# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Event, type: :model do
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:passenger) { create(:passenger, :without_photo) }
  let(:event) { create(:event, passenger: passenger, user: user, published: false) }

  context 'When validating an event that has a Passenger with no previous carrier' do
    describe 'validate an event' do
      before do
        event.update(published: true)
        event.save!
      end

      it 'sends an email to the new carrier' do
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries[0].to.first).to eq(user.email)
      end
    end
  end

  context 'When validating an event that has a Passenger with a previous carrier' do
    describe 'validate an event' do
      before do
        previous_event = create(:event, passenger: passenger, user: user)
        previous_event.save!
        new_event = create(:event, passenger: passenger, user: second_user, published: false)
        new_event.update(published: true)
        new_event.save!
      end

      it 'sends an email to the new carrier' do
        expect(ActionMailer::Base.deliveries.count).to eq(2)
        expect(ActionMailer::Base.deliveries.map{ |x| x.to.first } ).to include(user.email, second_user.email)
      end
    end
  end
end
