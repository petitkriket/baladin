class EventUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  def size_range
    200.kilobytes..8.megabytes
  end

  def fix_exif_rotation # this is my attempted solution
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

  process quality: 50

  # Create different versions of your uploaded files:
  version :marker do
    process :fix_exif_rotation
    process quality: 50
    process resize_to_fill: [32, 32]
  end

  version :thumb do
    process :fix_exif_rotation
    process quality: 50
    process resize_to_fit: [150, 150]
  end

  version :medium do
    process :fix_exif_rotation
    process quality: 50
    process resize_to_fit: [300, 300]
  end

  version :facebook do
    process :fix_exif_rotation
    process quality: 50
    process resize_to_fit: [1200, 630]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
