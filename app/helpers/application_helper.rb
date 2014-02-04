# ApplicationHelper
# View helpers for the whole application, not specific to any one
# model.
#
module ApplicationHelper
  # DateTime -> HTML
  # Returns the needed HTML to have a live updated moment.js
  # tag.
  #
  def from_now_tag(datetime)
    content_tag(:abbr, datetime.iso8601, title: datetime, class: 'datetime')
  end
end
