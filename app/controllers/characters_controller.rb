class CharactersController < ApplicationController

  # TODO: Access control for all needed actions.
  # TODO: Add destroy action.

  # GET /users/:id/character/new
  # Get the given user, and build it a character for it.
  #
  def new
    @user = User.find(params[:user_id])
    @character = @user.characters.build
  end

  # POST /users/:id/character
  # Creates a new Character with the passed in parameters. Redisplays the
  # new page when there are errors.
  #
  def create
    @user = User.find(params[:user_id])
    @character = @user.characters.build(character_params)

    # First character should be the main.
    if @user.characters.count == 0
      @character.send(:"main?=", true)
    else
      @character.send(:"main?=", false)
    end

    if @character.save
      redirect_to @user
    else
      render :new
    end
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
        @core << user.main_character if user.main_character
      elsif user.rank && user.rank.name == "Applicant"
        @applicants << user.main_character if user.main_character
      end
    end
  end

  protected

  # character_params: -> Hash
  # Permits the character fields for assignment.
  #
  def character_params
    params.require(:character).permit(:name, :server, :main?)
  end

end
