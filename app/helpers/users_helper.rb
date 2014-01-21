module UsersHelper

  # User -> String
  # Returns the formatted string for the users posts count.
  #
  def user_post_count(user)
    pluralize(number_with_delimiter(user.posts.count), "posts")
  end

end
