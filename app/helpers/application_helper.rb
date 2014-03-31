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
    classes = ['moment']

    classes << 'relative' if options[:relative]
    classes << (options[:time] ? 'datetime' : 'date')

    content_tag(:abbr, datetime.iso8601, title: datetime,
                                         class: classes.join(' '))
  end

  # Symbol -> HTML
  # Returns the appropriate HTML for an icon and text
  # for the given action.
  #
  def action_tag(action)
    case action
    when :new, :create
      "New ".html_safe + fa_icon("file-o")
    when :edit, :update
      "Edit ".html_safe + fa_icon("edit")
    when :destroy
      "Delete ".html_safe + fa_icon("trash-o")
    when :discussion
      "View Discussion ".html_safe + fa_icon("comment")
    end
  end
end
