class CharactersController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @character = @user.characters.build
  end

  def create
    @user = User.find(params[:user_id])
    @character = @user.characters.build(character_params)

    # First character should be the main.
    if @user.characters.count == 0
      @character.send(:"main?=", true)
    end

    if @character.save
      redirect_to @user
    else
      render :new
    end
  end

  def roster
    core_ranks = [
      "Guild Master",
      "Officer",
      "Loot Council",
      "Raider"
    ]

    @core = []
    @applicants = []
    User.all.each do |user|
      if core_ranks.include?(user.rank.name)
        @core << user.main_character
      elsif user.rank.name == "Applicant"
        @applicants << user.main_character
      end
    end
  end

  protected

  def character_params
    params.require(:character).permit(:name, :server, :main?)
  end

end
