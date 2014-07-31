# PostablesHelper
# View helpers specific to postables.
#
module PostablesHelper
  LABELS = {
    'Application' => 'App',
    'Boss'        => 'Boss',
    'Raid'        => 'Raid',
    'Topic'       => 'Topic'
  }

  # User -> HTML
  # Returns HTML for a link to the given postable.
  #
  def postable_tag(postable, options = {})
    options = { label: false }.merge(options)
    link_to postable_path(postable) do
      if options[:label]
        klass = postable.class.to_s
        css_class = "status #{klass.downcase.dasherize}"
        concat content_tag(:span, LABELS[klass], class: css_class)
        concat "\n"
      end
      concat content_tag(:span, postable)
    end
  end
end
