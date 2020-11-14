# frozen_string_literal: true

namespace :seeding do
  desc 'Create a range of fake User and Events for a given Passenger, do bin/rails seeding:create_events\[42,1,8\]'
  task :create_events, %i[passenger_id min max] => :environment do |_t, args|
    raise StandardError, 'STOP ! No seeding allowed in "production" environment' if Rails.env.production?

    min = args[:min].to_i
    max = args[:max].to_i
    users = []
    events = []
    passenger = Passenger.find(args[:passenger_id])
    raise MissingEnvVarException, "Passenger with ID #{args[:passenger_id]} cannot be found" if passenger.nil?

    puts "Creating a range of #{min}-#{max} Events for Passenger #{args[:passenger_id]}..."
    rand(min..max).times do
      users << user = FactoryBot.create(:user)
      events << FactoryBot.create(:event, passenger: passenger, user: user)
    end
    puts "Created #{users.count} Users sharing #{events.count} Events"
  end
end
