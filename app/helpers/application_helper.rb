# require "redcarpet"
module ApplicationHelper
  def markdown(text)
    options = {
      # removes HTML tags from the output
      filter_html:     true,
      # inserts <br /> tags in paragraphs where are newlines
      hard_wrap:       true,
      # hash for extra link options, for example 'nofollow'
      link_attributes: { rel: 'nofollow', target: '_blank' },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      #will parse links without need of enclosing them
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = ::Redcarpet::Render::HTML.new(options)
    markdown = ::Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
