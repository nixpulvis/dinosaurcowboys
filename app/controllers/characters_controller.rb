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

  # DELETE /users/:user_id/character/:id
  # Deletes the character.
  #
  def destroy
    begin
      @character.destroy
    rescue Character::DestoryError => e
      redirect_to :back, alert: e.message
      return
    end

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
    @classes = @characters.group_by(&:klass).each do |_klass, characters|
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
