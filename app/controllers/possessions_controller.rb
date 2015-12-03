class PossessionsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

  def create
    @game = Game.find(params[:game_id])
    current_user.possess(@game)
    respond_to do |format|
      format.html { redirect_to @game }
      format.js
    end
  end

  def destroy
    @game = Possession.find(params[:id]).game
    current_user.unpossess(@game)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

end
