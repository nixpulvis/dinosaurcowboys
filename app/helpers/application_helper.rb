# ApplicationHelper
# View helpers for the whole application, not specific to any one
# model.
#
module ApplicationHelper
  # DateTime -> HTML
  # Returns the needed HTML to have a live updated moment.js date.
  #
  # Options:
  #
  # `relative: true` yields "3 days ago".
  # `relative: false` (default) yields "February 4th 2014, 12:54:26 pm"
  #
  # `time: true` (default) yields "February 4th 2014, 12:54:26 pm"
  # `time: false` yields "February 4th 2014"
  #
  def date_tag(datetime, options = {})
    options = { relative: false, time: true }.merge(options)
    classes = ['live-time']

    classes << 'relative' if options[:relative]
    classes << (options[:time] ? 'datetime' : 'date')

    content_tag(:abbr, datetime.iso8601, title: datetime,
                                         class: classes.join(' '))
  end

  # Symbol -> HTML
  # Returns the appropriate HTML for an icon and text
  # for the given action.
  #
  # rubocop:disable Metrics/AbcSize, CyclomaticComplexity, MethodLength
  def action_tag(action, model, options = {})
    case action
    when :new, :create
      text = (options[:text] ? options[:text] : 'New') + ' '
      text.html_safe + fa_icon('file-o')
    when :edit, :update
      text = (options[:text] ? options[:text] : 'Edit') + ' '
      text.html_safe + fa_icon('edit')
    when :toggle
      if model.hidden?
        text = (options[:text] ? options[:text] : 'Show') + ' '
        text.html_safe + fa_icon('eye')
      else
        text = (options[:text] ? options[:text] : 'Hide') + ' '
        text.html_safe + fa_icon('eye')
      end
    when :destroy
      text = (options[:text] ? options[:text] : 'Delete') + ' '
      text.html_safe + fa_icon('trash-o')
    when :discussion
      'Discussion '.html_safe + fa_icon('comment')
    when :updates
      'Updates '.html_safe + fa_icon('history')
    end
  end

  # Symbol, Symbol -> HTML
  # Given a param to toggle and the symbol of the path method to
  # the path returns a link that toggles the given param.
  #
  def toggle_param_tag(param, path, options = {})
    if params[param]
      toggled_params = params.reject { |k, _| k == param.to_s }
      link_to "Excluding #{param.to_s.titleize}", send(path, toggled_params), options
    else
      toggled_params = params.merge(param => true)
      link_to "Including #{param.to_s.titleize}", send(path, toggled_params), options
    end
  end
end
