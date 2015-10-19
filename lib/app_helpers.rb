module AppHelpers
  def page_title(current_page)
    current_page.data.title || 'Webentwicklung'
  end

  def nav_li_link(title, url, opts = {})
    anchor = link_to title, url, opts
    page_path = "/#{current_page.path}"
    li_class = page_path.start_with?(url) ? 'active' : ''
    "<li class='#{li_class}'>#{anchor}</li>"
  end

  def recursive_data(field, page)
    page.data.fetch(field.to_s) do
      page.parent ? recursive_data(field, page.parent) : ''
    end
  end

  def link_to_slides(title, slide_name, available_at = Date.current)
    if Date.current >= available_at
      link_to title, "#{cc(:site).revealjs_host}/?sourceURI=#{cc(:site).slides_host}/site/slides/#{slide_name}", target: '_blank'
    else
      "<abbr title='Verfügbar ab: #{available_at}'>#{title}</abbr>"
    end
  end

  def slide_image_tag(src)
    image_tag slide_image_src(src)
  end

  def slide_image_src(src)
    "#{cc(:site).slides_host}/images/slides/#{src}"
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
