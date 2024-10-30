source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails", "8.0.0.rc2"
gem "propshaft"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "faraday"
gem "jwt"
gem "view_component"
gem "shrine"
gem "pagy"
gem "kredis"
gem "faraday-multipart"
gem "marcel"
gem "simple_form"
gem "redcarpet"


group :development, :test do
  gem "dotenv", ">= 3.0"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "erb_lint", require: false
  gem "annotate"
  gem "web-console"
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem "capybara", require: false
  gem "selenium-webdriver", require: false
end
