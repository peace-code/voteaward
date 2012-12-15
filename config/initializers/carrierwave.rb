CarrierWave.configure do |config|
  config.fog_credentials = YAML.load_file(Rails.root.join('config','credentials','fog_credential.yml')).symbolize_keys
  config.fog_directory = "voteaward-#{Rails.env}"
end