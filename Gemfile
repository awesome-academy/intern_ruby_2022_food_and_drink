source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"

gem "bcrypt", "~> 3.1.11"
gem "bootsnap", ">= 1.4.4", require: false
gem "bootstrap-sass"
gem "carrierwave"
gem "cocoon"
gem "config"
gem "faker"
gem "font-awesome-sass"
gem "figaro"
gem "jbuilder", "~> 2.7"
gem "jquery-rails"
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.6", ">= 6.1.6.1"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "toastr_rails"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

gem "pagy"
source "https://rails-assets.org" do
  gem "rails-assets-angular"
  gem "rails-assets-bootstrap"
  gem "rails-assets-leaflet"
end

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
