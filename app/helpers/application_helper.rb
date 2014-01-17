module ApplicationHelper

  # User -> HTML
  # <2 rbates @ railscasts.
  #
  def avatar_tag(user, options = {})
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    source = "http://gravatar.com/avatar/#{gravatar_id}.png?s=50"

    image_tag(source, options)
  end

  # DateTime -> HTML
  # Returns the needed HTML to have a live updated moment.js
  # tag.
  #
  def from_now_tag(datetime)
    content_tag(:abbr, datetime.iso8601, title: datetime, class: "datetime")
  end

end
