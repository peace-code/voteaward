CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  if Rails.env.development?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_KEY_DEV'],
      aws_secret_access_key: ENV['AWS_SECRET_DEV'],
      region: ENV['AWS_REGION_DEV']
    }
    config.fog_directory = ENV['AWS_BUCKET_DEV']
  elsif Rails.env.test?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_KEY_TEST'],
      aws_secret_access_key: ENV['AWS_SECRET_TEST'],
      region: ENV['AWS_REGION_TEST']
    }
    config.fog_directory = ENV['AWS_BUCKET_TEST']
  else Rails.env.production?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET'],
      region: ENV['AWS_REGION']
    }
    config.fog_directory = ENV['AWS_BUCKET']
  end
end
