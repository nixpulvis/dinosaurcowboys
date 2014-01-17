module ApplicationHelper

  # User -> String(URL)
  # <2 rbates @ railscasts.
  #
  def avatar_tag(user, options = {})
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    source = "http://gravatar.com/avatar/#{gravatar_id}.png?s=50"

    image_tag(source, options)
  end

end
