module AppHelpers
  def page_title(page = current_page)
    page.data.title || 'Webentwicklung'
  end

  def legacy_link_to_slides(title, slides_name, theme: 'black')
    "<a href='slides/#{slides_name}.html'>#{title}</a> (#{revealjs_link "/site/courses/ws2015/slides/#{slides_name}.html"})"
  end

  def readable_file_name(file)
    parts = slide_file_basename(file).split('-')
    parts.shift
    parts.map(&:capitalize) * ' '
  end

  # Returns the current course context.
  # Either a string, e.g. "ss2016" or nil
  #
  # @return [String, nil]
  def current_course
    path = current_page.path.split('courses/').last || ''
    path.split('/').first
  end

  def current_course_nav_items
    course_name = current_course or return
    data.courses.semester[course_name].to_h.each_with_object({}) do |(title, url), h|
      h[title] = "/site/courses/#{course_name}/#{url}"
    end
  end

  def nav_active_class(course)
    if current_page.path.include? "/courses/#{course}/"
      'active'
    end
  end

  def course_button_class(url, page = current_page)
    begin
      return 'active' if page.url == url
    end while page = page.parent
  end

  def current_course?
    !!current_course
  end

  def slide_uri(file)
    "slides/#{slide_file_basename(file)}.html"
  end

  def slide_file_basename(file)
    File.basename(file, '.html.md')
  end

  def slide_path(file)
    file.split('/source/').last.split('.md').first
  end

  def revealjs_link(slide_path, theme: 'black')
    link_to 'View slides', revealjs_url(slide_path, theme: theme)
  end

  def revealjs_url(slide_path, theme: 'black')
    "/revealjs?theme=#{theme}&sourceURI=#{cc(:site).portal_host}/#{slide_path}"
  end

  def _revealjs_url(slides_name, theme:)
    "#{cc(:site).revealjs_host}/?theme=#{theme}&sourceURI=#{cc(:site).portal_host}/site/slides/revealjs/#{slides_name}.html"
  end

  def slide_image_tag(src, opts = {})
    image_tag slide_image_src(src), opts
  end

  def view_on_github_url(page = current_page)
    "#{cc(:site).github_repo_url}/blob/master/source/#{page.file_descriptor.relative_path}"
  end

  def slide_image_src(src)
    "#{cc(:site).portal_host}/images/slides/#{src}"
  end

  def cssdeck_snippet(id, version: 0, show: 'html,output', height: 400)
    "<pre class='_cssdeck_embed' data-pane='#{show}' data-height=#{height} data-user='grekko' data-href='#{id}' data-version='#{version}'></pre>" +
    "<script async src='//cssdeck.com/assets/js/embed.js'></script><br/>" +
    "<a href='http://cssdeck.com/labs/#{id}'>Zum Code-Snippet</a>"
  end

  def jsfiddle_snippet(id, height: 400)
    "<iframe width='100%' sandbox='allow-modals allow-same-origin allow-scripts' height='#{height}' src='//jsfiddle.net/gregoryigelmund/#{id}/embedded/' allowfullscreen='allowfullscreen' frameborder='0'></iframe>"
  end

  def js_snippet(id)
    cssdeck_snippet(id, show: 'js')
  end

  def code_block(language: 'html', &block)
    escaped_html = html_escape { block.call }
    "<pre><code class='language-#{language}'>#{escaped_html}</code></pre>"
  end

  def html_escape(&block)
    ERB::Util.html_escape String.new(block.call)
  end

  def current_page_dir(page = current_page)
    __extract_paths(page).pop
  end

  def __extract_paths(page)
    page.path.split(?/).tap do |paths|
      paths.pop
    end
  end
end
