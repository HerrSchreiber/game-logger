class GamesController < ApplicationController

	def autocomplete
		render json: Game.search(params[:query],limit: 5)
	end

	def show
		@game = Game.find(params[:id])
		@users = @game.users.paginate(page: params[:page])
	end

end
