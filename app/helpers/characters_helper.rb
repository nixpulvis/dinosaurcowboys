# CharactersHelper
# View helpers specific to characters.
#
module CharactersHelper
  # Character -> HTML
  # Returns a span tag to be formated as a wow name. Class
  # colored and all.
  #
  def character_tag(character)
    content =
      if block_given?
        yield(character)
      else
        character
      end

    content_tag(:span, content, class: "character #{character.klass}")
  end

  # Character -> HTML
  # Returns a link to the character in the armory.
  #
  def armory_tag(character)
    link_to character.armory_url, class: 'armory' do
      character_tag(character)
    end
  end
end
