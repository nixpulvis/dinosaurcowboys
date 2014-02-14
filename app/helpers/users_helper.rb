# UsersHelper
# View helpers specific to users.
#
module UsersHelper
  # User -> HTML
  # Returns an image tag for the given users avatar.
  #
  def avatar_tag(user, options = {})
    options.merge!(class: 'avatar', data: { failover: user.main.thumbnail })

    if user.avatar.exists?
      image_tag(user.avatar.url(:thumb), options)
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      source = "http://gravatar.com/avatar/#{gravatar_id}.png?s=50&d=404"

      image_tag(source, options)
    end
  end

  # User -> String
  # Returns the formatted string for the users posts count.
  #
  def user_post_count(user)
    pluralize(number_with_delimiter(user.posts.count), 'post')
  end
end
