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

  def link_to_slides(title, slides_name, available_at = Date.current)
    if Date.current >= available_at
      "<a href='/site/slides/#{slides_name}'>#{title}</a> (#{slides_link(slides_name)})"
    else
      "<abbr title='Verfügbar ab: #{available_at}'>#{title}</abbr>"
    end
  end

  def slides_link(slides_name)
    link_to 'Slides', revealjs_url(slides_name), target: '_blank'
  end

  def revealjs_url(slides_name)
    "#{cc(:site).revealjs_host}/?sourceURI=#{cc(:site).slides_host}/site/slides/revealjs/#{slides_name}"
  end

  def slide_image_tag(src, opts = {})
    image_tag slide_image_src(src), opts
  end

  def html_escape(&block)
    ERB::Util.html_escape String.new(block.call)
  end

  def slide_image_src(src)
    "#{cc(:site).slides_host}/images/slides/#{src}"
  end

  def current_page_dir(page)
    __extract_paths(page).pop
  end


  def __extract_paths(page)
    page.path.split(?/).tap do |paths|
      paths.pop
    end
  end

  # Markdown helpers
  def md_image(path, alt, opts = {})
    "![#{alt}](images/#{path} '#{alt}')"
  end
end
