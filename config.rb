# Load Slim lang
require 'slim'

# Load ActiveSupport::Time
require 'active_support/time'

# Load code from lib directory
Dir[__dir__ + '/lib/**/*.rb'].each { |rb| require_relative rb }

# Server middlewares
use Middlewares::AccessControlAllowAllOrigins

# TODO:
# Slides currently have to layout since they are fetched by reveal.js
# and presented in a different context (with another layout).
# A much nicer approach would be to serve two separate files, one for
# reveal.js and a readable/printable version which lives beside.
page 'site/slides/*', layout: false
page 'site/slides/index.html', layout: 'layout'

# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Sprockets
sprockets.append_path 'source/sass/'

###
# Helpers
###
helpers AppHelpers

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload, apply_js_live: false
end

activate :directory_indexes

set :images_dir, 'images'
set :sass_assets_paths, ['source/sass']

# Build-specific configuration
configure :build do
  activate :asset_hash # Enable cache buster
end

