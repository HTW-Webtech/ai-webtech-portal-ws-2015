module AppHelpers
  def page_title(current_page)
    current_page.data.title || 'Webentwicklung'
  end

  def nav_li_link(title, url, opts = {})
    "<li class='#{nav_li_class(url)}'>#{link_to(title, url, opts)}</li>"
  end

  def nav_li_class(url)
    if current_page.path.include? url.split('/').last.split('.html').first
      'active'
    end
  end

  def file_from_url(url)
    url.split('/').last.split('.').first
  end

  def recursive_data(field, page)
    page.data.fetch(field.to_s) do
      page.parent ? recursive_data(field, page.parent) : ''
    end
  end

  def link_to_slides(title, slides_name, theme: 'black', available_at: Date.current)
    if Date.current >= available_at
      "<a href='/site/slides/#{slides_name}.html'>#{title}</a> (#{slides_link(slides_name, theme: theme)})"
    else
      "<abbr title='Noch nicht verfügbar'>#{title}</abbr>"
    end
  end

  def slides_link(slides_name, theme:)
    link_to 'View slides', revealjs_url(slides_name, theme: theme), target: '_blank'
  end

  def revealjs_url(slides_name, theme:)
    "#{cc(:site).revealjs_host}/?theme=#{theme}&sourceURI=#{cc(:site).slides_host}/site/slides/revealjs/#{slides_name}.html"
  end

  def slide_image_tag(src, opts = {})
    image_tag slide_image_src(src), opts
  end

  def edit_on_github_url(page)
    "#{cc(:site).github_repo_url}/blob/master/source/#{page.file_descriptor.relative_path}"
  end

  def slide_image_src(src)
    "#{cc(:site).slides_host}/images/slides/#{src}"
  end

  def html_code(&block)
    escaped_html = html_escape { block.call }
    "<pre><code class='language-html'>#{escaped_html}</code></pre>"
  end

  def html_escape(&block)
    ERB::Util.html_escape String.new(block.call)
  end

  def current_page_dir(page)
    __extract_paths(page).pop
  end


  def __extract_paths(page)
    page.path.split(?/).tap do |paths|
      paths.pop
    end
  end
end
