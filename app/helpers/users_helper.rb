# UsersHelper
# View helpers specific to users.
#
module UsersHelper
  # User -> HTML
  # Returns HTML for a link to the given user.
  #
  def user_tag(user)
    link_to user_path(user) do
      character_tag(user.main)
    end
  end

  # User -> HTML
  # Returns an image tag for the given users avatar.
  #
  def avatar_tag(user, options = {})
    options.merge!(class: 'avatar')

    if user.avatar && user.avatar.file.exists?
      image_tag(user.avatar.url(:thumb), options)
    else
      character_avatar_tag(user.main, options)
    end
  end

  # User -> String
  # Returns the formatted string for the users posts count.
  #
  def user_post_size(user)
    pluralize(number_with_delimiter(user.posts.size), 'post')
  end
end
