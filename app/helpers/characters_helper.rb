# CharactersHelper
# View helpers specific to characters.
#
module CharactersHelper
  # Character -> HTML
  # Returns a span tag to be formated as a wow name. Class
  # colored and all.
  #
  def character_tag(character)
    content_tag(:span, character, class: "character #{character.klass}")
  end

  # Character -> HTML
  # Returns an image for the character base on the armory.
  #
  def character_avatar_tag(character, options = {})
    data = { fallback: image_path('fallback_avatar.jpg') }
    options.merge!(class: 'avatar', data: data)

    image_tag(character.thumbnail, options)
  end

  # Character -> HTML
  # Returns a link to the character in the armory.
  #
  def armory_tag(character)
    link_to character.armory_url, class: 'armory', target: '_blank' do
      "#{character_tag(character)} #{fa_icon('external-link')}".html_safe
    end
  end
end
