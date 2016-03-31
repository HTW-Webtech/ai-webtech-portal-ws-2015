# Load Slim lang; Used for slides templating
require 'slim'

# Load ActiveSupport::Time
require 'active_support/time'
require 'active_support/core_ext/string/output_safety'

# Load code from lib directory
Dir[__dir__ + '/lib/**/*.rb'].each { |rb| require_relative rb }

# Reveal.js configuration
page 'revealjs/*', layout: false

# Template Engines
set :markdown_engine, :kramdown

set :images_dir, 'images'
helpers AppHelpers # Load external helper files

# Production configuration
configure :build do
  # activate :minify_javascript
end

# Development configuration
configure :development do
  activate :livereload, host: '127.0.0.1', apply_js_live: false
end

set :show_exceptions, false # Disable Rack::ShowExceptions middleware
require 'better_errors'
require 'binding_of_caller'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

