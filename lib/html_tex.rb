# frozen_string_literal: true

# Converts HTML code to a TeX like syntax
class HtmlTex
  def self.convert(html)
    tex = html
    # Convert tags that need to be opened and closed in TeX
    direct_conversions.each do |html_tag, tex_tag|
      tex = tex.gsub(/<\s*#{html_tag}{1}\b(\s[^>]*>|>)/i, "\\#{tex_tag}")
    end

    # Take care of tags which, in TeX, only need to be opened
    simple_conversions.each do |html_tag, tex_tag|
      tex = tex.gsub(/<\s*#{html_tag}{1}\b(\s[^>]*>|>)/i, "\\#{tex_tag} ")
      # Remove closing tags, if they exist
      tex = tex.gsub(/<\s*\/\s*#{html_tag}+>/i, '')
      tex = tex.gsub(/<\s*\/\s*#{html_tag}{1}\b(\s[^>]*>|>)/i, '')
    end

    # Create TeX environments
    environment_conversions.each do |html_tag, tex_tag|
      # Open environment
      tex = tex.gsub(/<\s*#{html_tag}{1}\b(\s[^>]*>|>)/i, "\\begin{#{tex_tag}}")
      # Close environment
      tex = tex.gsub(/<\s*\/\s*#{html_tag}{1}\b(\s[^>]*>|>)/i, "\\end{#{tex_tag}}")
    end

    # Close remaining tags
    tex = tex.gsub(/<\s*\/\s*([a-zA-Z]+)>/, '}')
    tex
  end

  def self.direct_conversions
    {
      h1: 'part{',
      h2: 'chapter{',
      h3: 'section{',
      h4: 'subsection{',
      h5: 'subsubsection{',
      h6: 'textbf{',
      i: 'textit{',
      u: 'underline{',
      b: 'textbf{',
      strong: 'textbf{',
      br: '\\'
    }
  end

  def self.simple_conversions
    {
      p: '\\',
      hr: 'hrule',
      li: 'item'
    }
  end

  def self.environment_conversions
    {
      ol: 'enumerate',
      ul: 'itemize',
      body: 'document'
    }
  end
end
