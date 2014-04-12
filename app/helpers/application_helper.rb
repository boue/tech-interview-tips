module ApplicationHelper
  class HTMLwithPygments < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language, :options => {:lineanchors => "line"})
    end
  end

  def markdown(text)
    renderer = HTMLwithPygments.new(prettify: true,
      hard_wrap: true,
      filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      highlight: true,
      quote: true,
      footnotes: true,
      tables: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end
end
