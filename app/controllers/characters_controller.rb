class CharactersController < ApplicationController

  # TODO: Access control for all needed actions.
  # TODO: Add destroy action.

  # GET /users/:user_id/character/new
  # Get the given user, and build it a character for it.
  #
  def new
    @user = User.find(params[:user_id])
    @character = @user.characters.build
  end

  # POST /users/:user_id/character
  # Creates a new Character with the passed in parameters. Redisplays the
  # new page when there are errors.
  #
  def create
    @user = User.find(params[:user_id])
    @character = @user.characters.build(character_params)

    # First character should be the main.
    if @user.characters.count == 0
      @character.main = true
    else
      @character.main = false
    end

    if @character.save
      redirect_to @user
    else
      render :new
    end
  end

  # GET /users/:user_id/character/:id
  # Provides the given character of a given user.
  #
  def show
    @user = User.find(params[:user_id])
    @character = @user.characters.find(params[:id])
  end

  # GET /users/:user_id/character/:id/edit
  def edit
    @user = User.find(params[:user_id])
    @character = @user.characters.find(params[:id])
    unauthorized unless current_user.admin? || current_user == @user
  end

  # PATCH or PUT /users/:user_id/character/:id
  # As admin, updates the specified character with the given parameters.
  # As specified user, updates the character with the given parameters.
  # As non-admin, redirects with access error.
  #
  def update
    @user = User.find(params[:user_id])
    @character = @user.characters.find(params[:id])
    unauthorized unless current_user.admin? || current_user == @user

    if @character.update_attributes(character_params)
      redirect_to user_character_path(@user, @character)
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/character/:id
  # As admin, destroys the specified character.
  # As specified user, destroys the character.
  # As non-admin, redirects with access error.
  #
  def destroy
    @user = User.find(params[:user_id])
    @character = @user.characters.find(params[:id])
    unauthorized unless current_user.admin? || current_user == @user

    @character.destroy
    redirect_to user_path(@user)
  end

  # GET /roster
  # Provides the users that are part of the core, and applicants.
  #
  def roster
    core_ranks = [
      "Guild Master",
      "Officer",
      "Loot Council",
      "Raider"
    ]

    # TODO: Use one instance variable, and clean this up.
    @core = []
    @applicants = []
    User.all.each do |user|
      if user.rank && core_ranks.include?(user.rank.name)
        @core << user.main if user.main
      elsif user.rank && user.rank.name == "Applicant"
        @applicants << user.main if user.main
      end
    end
  end

  protected

  # character_params: -> Hash
  # Permits the character fields for assignment.
  #
  def character_params
    params.require(:character).permit(:name, :server, :main)
  end

end
