require 'redcarpet'

module PartyShark
  module Markdownable
    ALLOWED_MARKDOWN = {
      :elements => [
        'a', 'b', 'blockquote', 'br', 'caption', 'cite', 'code', 'col',
        'colgroup', 'dd', 'dl', 'dt', 'em', 'i', 'img', 'li', 'ol', 'p', 'pre',
        'q', 'small', 'strike', 'strong', 'sub', 'sup', 'table', 'tbody', 'td',
        'tfoot', 'th', 'thead', 'tr', 'u', 'ul', 'del', 'ins', 'h1', 'h2', 'h3',
        'h4', 'h5', 'h5', 'hr', 'kbd', 'iframe'],

      :attributes => {
        'a'          => ['href', 'title'],
        'blockquote' => ['cite'],
        'col'        => ['span', 'width'],
        'colgroup'   => ['span', 'width'],
        'img'        => ['align', 'alt', 'height', 'src', 'title', 'width'],
        'ol'         => ['start', 'type'],
        'q'          => ['cite'],
        'table'      => ['summary', 'width'],
        'td'         => ['abbr', 'axis', 'colspan', 'rowspan', 'width'],
        'th'         => ['abbr', 'axis', 'colspan', 'rowspan', 'scope',
                         'width'],
        'ul'         => ['type'],
        'iframe'     => ['src', 'width', 'height'],
      },

      :protocols => {
        'a'          => {'href' => ['ftp', 'http', 'https', 'mailto',
                                    :relative]},
        'blockquote' => {'cite' => ['http', 'https', :relative]},
        'img'        => {'src'  => ['http', 'https', :relative]},
        'q'          => {'cite' => ['http', 'https', :relative]}
      }
    }

    def markdown(field)
      options = {
        :fenced_code_blocks => true,
      }
      parser = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
      dirty = parser.render send(field)
      Sanitize.clean(dirty, ALLOWED_MARKDOWN)
    end

  end
end
