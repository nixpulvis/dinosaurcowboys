module CharactersHelper

  # Character -> HTML
  # Returns a span tag to be formated as a wow name. Class
  # colored and all.
  #
  def character_tag(character)
    content_tag(:span, character, class: "character #{character.klass}")
  end

end
