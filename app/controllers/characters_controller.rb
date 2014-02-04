# CharactersController
# Controller for the Character model nested inside a User.
# The roster action acts kinda like the index action.
#
# Actions: [new, create, show, edit, update, destroy, roster]
#
class CharactersController < ApplicationController
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
    if user.characters.count == 0
      @character.main = true
    else
      @character.main = false
    end

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
    user = User.find(params[:user_id])
    @character = user.characters.find(params[:id])
    authorize @character
  end

  # GET /users/:user_id/character/:id/edit
  # Provides the user and character for editing.
  #
  def edit
    user = User.find(params[:user_id])
    @character = user.characters.find(params[:id])
    authorize @character
  end

  # PATCH or PUT /users/:user_id/character/:id
  # Allows user to update the character.
  #
  def update
    user = User.find(params[:user_id])
    @character = user.characters.find(params[:id])
    authorize @character

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
    user = User.find(params[:user_id])
    @character = user.characters.find(params[:id])
    authorize @character

    @character.destroy
    redirect_to user_path(@character.user)
  end

  # GET /roster
  # Provides the users that are part of the core, and applicants.
  #
  def roster
    @characters = policy_scope(Character).where(main: true)
    authorize @characters

    # TODO: Use one instance variable?
    @cores = []
    @trials = []

    @characters.each do |character|
      if character.user.rank.try(:>=, 'Raider')
        @cores << character
      elsif character.user.rank.try(:==, 'Trial')
        @trials << character
      end
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
