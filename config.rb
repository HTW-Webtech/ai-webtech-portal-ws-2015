require 'slim'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page 'site/slides/*', layout: false
page 'site/slides/index.html', layout: 'layout'
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end
# page "*/aufgaben/*", layout: :_aufgabe

# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Sprockets
sprockets.append_path 'source/sass/'

###
# Helpers
###
helpers do
  def page_title(current_page)
    current_page.data.title || 'Webentwicklung'
  end

  def nav_link_to(title, url)
    opts = {}
    opts[:class] = 'active' if current_page.path.start_with? url
    link_to title, url, opts
  end

  def recursive_data(field, page)
    page.data.fetch(field.to_s) do
      page.parent ? recursive_data(field, page.parent) : ''
    end
  end

  def slides_link(title, slide_name, available_at = Date.current)
    if Date.current >= available_at
      link_to title, "http://localhost:1947/?sourceURI=http://localhost:8011/site/slides/#{slide_name}", target: '_blank'
    else
      "<abbr title='Verfügbar ab: #{available_at}'>#{title}</abbr>"
    end
  end

  def slide_image_tag(src)
    image_tag 'http://localhost:8011/images/slides/' + src
  end

  def current_page_dir(page)
    __extract_paths(page).pop
  end

  def current_page_path(page)
    paths = __extract_paths(page).map { |part| "#{part}/" }
    "/#{paths.join}"
  end

  def __extract_paths(page)
    page.path.split(?/).tap do |paths|
      paths.pop
    end
  end
end

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload, apply_js_live: false
end

activate :directory_indexes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :images_dir, 'images'
set :sass_assets_paths, ['source/sass']

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end


class AccessControlAllowAllOrigins
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

		headers['Access-Control-Allow-Origin'] = '*'

    [status, headers, response]
  end
end

use AccessControlAllowAllOrigins
