# frozen_string_literal: true

CarrierWave.configure do |config|
  if Rails.env.test?

    CarrierWave.configure do |config|
      config.storage = :file
    end

    Dir["#{Rails.root}/app/uploaders/*.rb"].sort.each { |file| require file }

    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?

      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end

  if Rails.env.development? || Rails.env.production? || Rails.env.staging?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :access_key_id),
      aws_secret_access_key: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :secret_access_key),
      region: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :s3_region)
    }
    config.fog_directory = Rails.application.credentials.dig(Rails.env.to_sym, :aws, :s3_bucket)
    config.fog_public = false

    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.write(current_path) { quality(percentage) }
        img = yield(img) if block_given?
        img
      end
    end
  end
end
