module PartyShark
  # PartyShark::Markdown
  # Simple module to parse markdown on content of ruby classes.
  #
  # Simply `include PartyShark::Markdownable` then in the views
  # `<%= object.markdown(:field) %>`
  #
  module Markdownable
    ALLOWED_MARKDOWN = {
      elements: %w(a b blockquote br caption cite code col colgroup dd dl dt
                   em i img li ol p pre q small strike strong sub sup table
                   tbody td tfoot th thead tr u ul del ins h1 h2 h3 h4 h5 h5
                   mark hr kbd iframe),

      attributes: {
        'a'          => %w(href title),
        'blockquote' => ['cite'],
        'col'        => %w(span width),
        'colgroup'   => %w(span width),
        'img'        => %w(align alt height src title width),
        'ol'         => %w(start type),
        'q'          => ['cite'],
        'table'      => %w(summary width),
        'td'         => %w(abbr axis colspan rowspan width),
        'th'         => %w(abbr axis colspan rowspan scope width),
        'ul'         => ['type'],
        'iframe'     => %w(src width height)
      },

      protocols: {
        'a'          => { 'href' => ['ftp', 'http', 'https', 'mailto',
                                     :relative] },
        'blockquote' => { 'cite' => ['http', 'https', :relative] },
        'img'        => { 'src'  => ['http', 'https', :relative] },
        'q'          => { 'cite' => ['http', 'https', :relative] }
      }
    }

    def markdown(field)
      options = {
        fenced_code_blocks: true,
        tables: true,
        strikethrough: true,
        underline: true,
        highlight: true,
        autolink: true,
        disable_indented_code_blocks: true
      }
      parser = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
      dirty = parser.render send(field)
      Sanitize.clean(dirty, ALLOWED_MARKDOWN).html_safe
    end
  end
end
