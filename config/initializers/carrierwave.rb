CarrierWave.configure do |config|
  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :access_key_id),
    aws_secret_access_key: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :secret_access_key),
    region: Rails.application.credentials.dig(Rails.env.to_sym, :aws, :s3_region)
  }
  config.fog_directory  = Rails.application.credentials.dig(Rails.env.to_sym, :aws, :s3_bucket)
  config.fog_public     = false

  # Use AWS storage if in production
  if Rails.env.production? || Rails.env.staging?
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
