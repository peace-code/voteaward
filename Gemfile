source 'https://rubygems.org'
ruby '2.4.1'

gem 'rails', '4.2.8'

# db
gem 'mongoid', '4.0.2'
gem 'mongoid-observers', '0.2.0'
gem 'geocoder'

# file upload
gem 'mini_magick'
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'fog-aws', '0.12.0'

# auth
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

# sns
gem 'koala'
gem 'twitter'

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'therubyracer', '~>0.12.3'
gem 'less-rails', '~>2.8.0'
gem 'twitter-bootstrap-rails', '2.2.8'

gem 'jquery-rails'
gem 'simple_form'

gem 'jbuilder'

gem 'dotenv-rails'
gem 'puma'

group :development, :test do
  gem 'pry-byebug'
  gem 'spring'
  gem 'railroady'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'capistrano', '~> 3.8'
  gem 'capistrano-rbenv',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

group :production do
  gem 'rails_12factor'
end
