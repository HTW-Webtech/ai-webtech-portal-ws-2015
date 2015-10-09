require 'slim'

# activesupport
require 'active_support/time'

# Load lib code
Dir[__dir__ + '/lib/**/*.rb'].each { |rb| require_relative rb }

# Server middlewares
use Middlewares::AccessControlAllowAllOrigins

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
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

