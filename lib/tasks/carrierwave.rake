namespace :carrierwave do
  desc 'Recreate versions for CarrierWave'
  task recreate_versions: :environment do
    Passenger.all.where('photo IS NOT NULL').each do |d|
      d.photo.recreate_versions!
    end
    Event.all.where('photo IS NOT NULL').each do |d|
      d.photo.recreate_versions!
    end
  end
end
