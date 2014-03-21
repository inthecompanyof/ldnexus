module MarkdownHelper
  class PygmentsRenderHTML < Redcarpet::Render::HTML
    def block_code(source, language)
      Pygments.highlight source, lexer: language, options: { linenos: true }
    end
  end

  def markdown(content)
    redcarpet_markdown.render(content).html_safe
  end

  def redcarpet_markdown
    @redcarpet_markdown ||= Redcarpet::Markdown.new renderer, extensions
  end

  def extensions
    {
      autolink: true,
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      strikethrough: true,
      lax_spacing: true,
      disable_indented_code_blocks: true
    }
  end

  def renderer
    PygmentsRenderHTML.new hard_wrap: true, filter_html: true, safe_links_only: true
  end
end
