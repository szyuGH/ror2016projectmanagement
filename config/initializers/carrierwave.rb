CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    region: 'eu-central-1',
    aws_access_key_id: ENV['S3_KEY'],
    aws_secret_access_key: ENV['S3_SECRET'],
    endpoint: "https://s3.eu-central-1.amazonaws.com",
  }

  if Rails.env.production?
    config.storage = :fog
  else
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads" # to let CarrierWave work on Heroku
  config.fog_directory = ENV['S3_BUCKET_NAME']
  config.fog_public = true
end
