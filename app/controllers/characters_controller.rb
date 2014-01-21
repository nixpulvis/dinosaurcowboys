class CharactersController < ApplicationController
  load_and_authorize_resource :user, except: :roster
  load_and_authorize_resource through: :user, except: :roster

  skip_authorization_check only: :roster  # Everyone can see the roster.

  # GET /users/:user_id/character/new
  # Get the given user, and build it a character for it.
  #
  def new
  end

  # POST /users/:user_id/character
  # Creates a new Character with the passed in parameters. Redisplays the
  # new page when there are errors.
  #
  def create
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
      redirect_to user_character_path(@user, @character)
    else
      render :edit
    end
  end

  # DELETE /users/:user_id/character/:id
  # Deletes the character.
  #
  def destroy
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

  private

  # character_params: -> Hash
  # Permits the character fields for assignment.
  #
  def character_params
    params.require(:character).permit(:name, :server, :main)
  end

end
