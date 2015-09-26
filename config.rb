###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
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

###
# Helpers
###
helpers do
  def recursive_data(field, page)
    page.data.fetch(field.to_s) do
      page.parent ? recursive_data(field, page.parent) : ''
    end
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
# set :markdown_engine, :kramdown
# set :markdown, syntax_highlighter: :rouge
set :liquid_engine, :liquid
set :sass_assets_paths, ['source/sass']

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

# require_relative './extensions/before_build_example'
