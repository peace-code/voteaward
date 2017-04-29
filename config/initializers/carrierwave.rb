CarrierWave.configure do |config|
  config.fog_credentials = { provider: ENV['FOG_PROVIDER'], local_root: ENV['FOG_ROOT'], endpoint: ENV['FOG_ENDPOINT'] }

  config.fog_directory = "voteaward-#{Rails.env}"
end
