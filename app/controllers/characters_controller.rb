# CharactersController
# Controller for the Character model nested inside a User.
# The roster action acts kinda like the index action.
#
# Actions: [new, create, show, edit, update, destroy, roster]
#
class CharactersController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy] do
    user = User.find(params[:user_id])
    @character = user.characters.find(params[:id])
    authorize @character
  end

  # GET /users/:user_id/character/new
  # Get the given user, and build it a character for it.
  #
  def new
    user = User.find(params[:user_id])
    @character = user.characters.build
    authorize @character
  end

  # POST /users/:user_id/character
  # Creates a new Character with the passed in parameters. Redisplays the
  # new page when there are errors.
  #
  def create
    user = User.find(params[:user_id])
    @character = user.characters.build(character_params)
    authorize @character

    # First character should be the main.
    @character.main = (user.characters.count == 0)

    if @character.save
      redirect_to user
    else
      render :new
    end
  end

  # GET /users/:user_id/character/:id
  # Provides the given character of a given user.
  #
  def show
  end

  # GET /users/:user_id/character/:id/edit
  # Provides the user and character for editing.
  #
  def edit
  end

  # PATCH or PUT /users/:user_id/character/:id
  # Allows user to update the character.
  #
  def update
    if @character.update_attributes(character_params)
      redirect_to user_character_path(@character.user, @character)
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/character/:id
  # Deletes the character.
  #
  def destroy
    @character.destroy
    redirect_to user_path(@character.user)
  end

  # GET /roster
  # Provides the users that are part of the core, and applicants.
  #
  def roster
    @characters = policy_scope(Character)
                    .includes(user: :rank)
                    .where(main: true)
    authorize @characters

    # Get only the characters over Trial rank and shown.
    @characters = @characters.select do |character|
      character.user.shown? && character.user.rank.try(:>=, 'Trial')
    end

    # Group and sort the characters.
    @classes = @characters.group_by(&:klass).each do |klass, characters|
      characters.sort! { |a, b| b.user.rank <=> a.user.rank }
    end
  end

  private

  # character_params: -> Hash
  # Permits the character fields for assignment.
  #
  def character_params
    permit = policy(@character || Character).permitted_attributes
    params.require(:character).permit(*permit)
  end
end
