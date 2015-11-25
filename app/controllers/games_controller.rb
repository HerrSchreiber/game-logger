class GamesController < ApplicationController

	def autocomplete
		render json: Game.search(params[:query],limit: 5)
	end

end
