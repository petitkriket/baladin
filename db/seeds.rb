# frozen_string_literal: true

if Rails.env.development?
  admin = CreateAdminService.new.dev
  puts "Super user created with following email: #{admin.email} and password : 'examplePassword!'"

  # variables
  passenger_count = 50
  few_items = (passenger_count * 0.2).round

  # create artworks
  passenger_count.times do
    FactoryBot.create(:passenger, :without_photo)
  end

  # create less popular artworks events
  passengers = Passenger.all
  passengers[0...few_items].each do |passenger|
    system "bin/rake seeding:create_events[#{passenger.id},1,1]"
  end

  # create popular artworks
  passengers[few_items.succ...passenger_count].each do |passenger|
    system "bin/rake seeding:create_events[#{passenger.id},2,8]"
  end

  puts "Created #{passengers.count} Passengers."
  puts "Created #{Event.all.count} Events."
  puts "Created #{User.all.count} Users."
end
