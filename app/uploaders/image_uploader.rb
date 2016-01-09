# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper # 4.0
  # include Sprockets::Helpers::IsolatedHelper # 4.0

  # Choose what kind of storage to use for this uploader:
  # storage :fog
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  # Process files as they are uploaded:
  process :resize_to_fit => [1024, 1024]

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [50, 50]
  end

  version :small do
    process :resize_to_fill => [260, 260]
  end

  version :large do
    process :resize_to_fill => [576, 400]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def get_exif( name )
    manipulate! do |img|
      return img["EXIF:" + name]
    end
  end
end
