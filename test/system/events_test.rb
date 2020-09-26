require 'application_system_test_case'

class EventsTest < ApplicationSystemTestCase
  setup do
    @event = events(:one)
  end

  test 'visiting the index' do
    visit events_url
    assert_selector 'h1', text: 'Events'
  end

  test 'creating a Event' do
    visit events_url
    click_on 'New Event'

    fill_in 'Address', with: @event.address
    fill_in 'City', with: @event.city
    fill_in 'Country', with: @event.country
    fill_in 'Latitude', with: @event.latitude
    fill_in 'Longitude', with: @event.longitude
    fill_in 'Passenger', with: @event.passenger_id
    fill_in 'Photo', with: @event.photo
    fill_in 'Published', with: @event.published
    fill_in 'User', with: @event.user_id
    click_on 'Create Event'

    assert_text 'Event was successfully created'
    click_on 'Back'
  end

  test 'updating a Event' do
    visit events_url
    click_on 'Edit', match: :first

    fill_in 'Address', with: @event.address
    fill_in 'City', with: @event.city
    fill_in 'Country', with: @event.country
    fill_in 'Latitude', with: @event.latitude
    fill_in 'Longitude', with: @event.longitude
    fill_in 'Passenger', with: @event.passenger_id
    fill_in 'Photo', with: @event.photo
    fill_in 'Published', with: @event.published
    fill_in 'User', with: @event.user_id
    click_on 'Update Event'

    assert_text 'Event was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Event' do
    visit events_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Event was successfully destroyed'
  end
end
