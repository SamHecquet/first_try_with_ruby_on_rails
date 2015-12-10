class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [600, 600]

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    if Rails.env.test?
      "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
  
  def cache_dir
    if Rails.env.test?
      "#{Rails.root}/spec/support/uploads/tmp"
    else
      "#{Rails.root}/tmp/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
