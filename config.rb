# Load Slim lang; Used for slides templating
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

Dir[__dir__ + '/source/site/slides/*.slim'].each do |slide|
  file_name = File.basename(slide).split('.html').first
  html_file = "#{file_name}.html"
  proxy "/site/slides/revealjs/#{html_file}", "/site/slides/#{html_file}"
end

Dir[__dir__ + '/source/site/slides/*.md'].each do |slidemd|
  proxy "/site/slides/revealjs/foo.html", "/site/slides/template.html", layout: false, locals: {
    markdown_filename: slidemd
  }
end

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
