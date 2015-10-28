# Load Slim lang
require 'slim'

# Load ActiveSupport::Time
require 'active_support/time'
require 'active_support/core_ext/string/output_safety'

# Load code from lib directory
Dir[__dir__ + '/lib/**/*.rb'].each { |rb| require_relative rb }

# Reveal.js configuration
use Middlewares::AccessControlAllowAllOrigins

# TODO:
# Slides currently have to layout since they are fetched by reveal.js
# and presented in a different context (with another layout).
# A much nicer approach would be to serve two separate files, one for
# reveal.js and a readable/printable version which lives beside.
page 'site/slides/*', layout: false
page 'site/slides/index.html', layout: 'layout'

# Template Engines
set :markdown_engine, :kramdown

# Sprockets
sprockets.append_path 'source/sass/'

# Create a sub-directory and index.html for each template
activate :directory_indexes
set :images_dir, 'images'
set :sass_assets_paths, ['source/sass']
helpers AppHelpers # Load external helper files

# Production configuration
configure :build do
  activate :asset_hash # Enable cache buster
end

# Development configuration
configure :development do
  activate :livereload, apply_js_live: false
end
