require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
# require "active_resource/railtie"
require "sprockets/railtie"
# require "active_record/railtie"

require "i18n/backend/fallbacks"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Voteaward
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true

    # Activate observers that should always be running.
    config.mongoid.observers = :promise_observer, :award_observer, :vote_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Seoul'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :ko

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # config.assets.compile = true
    # config.less.paths << "#{Rails.root}/lib/less/protractor/stylesheets"
    # config.less.compress = true

    # Prevent scaffold.css, javascripts from being generated
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
    end

    # oauth
    if Rails.env.development?
      config.facebook = {"client_id" => ENV['FACEBOOK_KEY_DEV'], "client_secret" => ENV['FACEBOOK_SECRET_DEV'] }
      config.twitter = {"client_id" => ENV['TWITTER_KEY_DEV'], "client_secret" => ENV['TWITTER_SECRET_DEV'] }
    elsif Rails.env.test?
      config.facebook = {"client_id" => ENV['FACEBOOK_KEY_DEV'], "client_secret" => ENV['FACEBOOK_SECRET_DEV'] }
      config.twitter = {"client_id" => ENV['TWITTER_KEY_DEV'], "client_secret" => ENV['TWITTER_SECRET_DEV'] }
    else Rails.env.production?
      config.facebook = {"client_id" => ENV['FACEBOOK_KEY'], "client_secret" => ENV['FACEBOOK_SECRET'] }
      config.twitter = {"client_id" => ENV['TWITTER_KEY'], "client_secret" => ENV['TWITTER_SECRET'] }
    end

    # mongoid
    config.generators do |g|
      g.orm :mongoid
    end

    # Configure fallbacks for mongoid errors:
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    config.i18n.fallbacks = {'ko' => 'en'}
  end
end
