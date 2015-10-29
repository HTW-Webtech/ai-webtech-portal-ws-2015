# Load Slim lang
require 'slim'

# Load ActiveSupport::Time
require 'active_support/time'
require 'active_support/core_ext/string/output_safety'

# Load code from lib directory
Dir[__dir__ + '/lib/**/*.rb'].each { |rb| require_relative rb }

# Reveal.js configuration
use Middlewares::AccessControlAllowAllOrigins
page 'site/slides/revealjs/*', layout: false
page 'site/slides/index.html', layout: 'layout'

Dir[__dir__ + '/source/site/slides/*'].each do |exercise_file|
  file_name = File.basename(exercise_file).split('.html').first
  html_file = "#{file_name}.html"
  proxy "/site/slides/revealjs/#{html_file}", "/site/slides/#{html_file}"
end

# Template Engines
set :markdown_engine, :kramdown

# Sprockets
sprockets.append_path 'source/sass/'

set :images_dir, 'images'
set :sass_assets_paths, ['source/sass']
helpers AppHelpers # Load external helper files

# Production configuration
configure :build do
  # activate :asset_hash # Currently breaks when parsing prism.js
  # activate :minify_javascript
  activate :gzip
end

# Development configuration
configure :development do
  activate :livereload, apply_js_live: false
end
