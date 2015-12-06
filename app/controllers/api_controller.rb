class ApiController < ApplicationController
	protect_from_forgery with: :null_session
	before_action :authenticate_user_from_key!, except: :login

	def showUser
		user = User.find_by(id: params[:user_id])
		if user.nil?
			render json: {error:"User does not exist"}
		else
			jsonUser = {}
			jsonUser["id"] = user.id
			jsonUser["name"] = user.name
			jsonUser["collection"] = selective_clone_games user.games
			render json: jsonUser
		end
	end

	def follow
		user = User.find_by(id: params[:user_id])
		if user.nil?
			render json: {error:"User does not exist"}
		else
			if @user.following? user
				render json: {error:"User already following that user"}
			else
				@user.follow(user);
				jsonUser = {}
				jsonUser["id"] = @user.id
				jsonUser["name"] = @user.name
				jsonUser["following"] = selective_clone_users @user.following
				render json: jsonUser
			end
		end
	end

	def unfollow
		user = User.find_by(id: params[:user_id])
		if user.nil?
			render json: {error:"User does not exist"}
		else
			if !@user.following? user
				render json: {error:"User not following that user"}
			else
				@user.unfollow(user);
				jsonUser = {}
				jsonUser["id"] = @user.id
				jsonUser["name"] = @user.name
				jsonUser["following"] = selective_clone_users @user.following
				render json: jsonUser
			end
		end
	end

	def getFollowing
		user = User.find_by(id: params[:user_id])
		if user.nil?
			render json: {error:"User does not exist"}
		else
			jsonUser = {}
			jsonUser["id"] = user.id
			jsonUser["name"] = user.name
			jsonUser["following"] = selective_clone_users user.following
			render json: jsonUser
		end
	end

	def getFollowers
		user = User.find_by(id: params[:user_id])
		if user.nil?
			render json: {error:"User does not exist"}
		else
			jsonUser = {}
			jsonUser["id"] = user.id
			jsonUser["name"] = user.name
			jsonUser["followers"] = selective_clone_users user.followers
			render json: jsonUser
		end
	end

	def showGame
		game = Game.find_by(id: params[:game_id])
		if game.nil?
			render json: {error:"Game does not exist"}
		else
			jsonGame = {}
			jsonGame["id"] = game.id
			jsonGame["title"] = game.title
			jsonGame["platform"] = game.platform
			jsonGame["publisher"] = game.publisher
			jsonGame["release"] = game.release
			jsonGame["owners"] = selective_clone_users game.users
			render json: jsonGame
		end
	end

	def addGame
		game = Game.find_by(id: params[:game_id])
		if game.nil?
			render json: {error:"Game does not exist"}
		else
			if user.possess? game
				render json: {error:"User already possesses that game"}
			else
				@user.possess(game)
				jsonUser = {}
				jsonUser["id"] = @user.id
				jsonUser["name"] = @user.name
				jsonUser["collection"] = selective_clone_games @user.games
				render json: jsonUser
			end
		end
	end

	def removeGame
		game = Game.find_by(id: params[:game_id])
		if game.nil?
			render json: {error:"Game does not exist"}
		else
			if !user.possess? game
				render json: {error:"User doesn't possess that game"}
			else
				@user.unpossess(game)
				jsonUser = {}
				jsonUser["id"] = @user.id
				jsonUser["name"] = @user.name
				jsonUser["collection"] = selective_clone_games @user.games
				render json: jsonUser
			end
		end
	end

	def findGame
		games = selective_clone_games Game.search(params[:query],limit: 5)
		render json: games
	end

	def login
		if !params[:email] || !params[:password]
			render json: {error:"username or password missing"}
		else
			user = User.find_by(email: params[:email].downcase)
			if user && user.authenticate(params[:password])
				if user.activated?
					render json: {api_key:user.api_key}
				else
					render json: {error:"User not activated"}
				end
			else
				render json: {error:"Invalid email/password combination"}
			end
		end
	end

	private
		
		def authenticate_user_from_key!
			if !params[:api_key]
				render json: {error:"API key missing!"}
			else
				@user = nil
				User.find_each do |u|
					if u.api_key == params[:api_key]
						@user = u
					end
				end
				if @user.nil?
					render json: {error:"API key invalid!"}
			end
		end

		def selective_clone_games(games)
			truncatedGames = []
			games.each do |game|
				jsonGame = {}
				jsonGame["id"] = game.id
				jsonGame["title"] = game.title
				jsonGame["platform"] = game.platform
				jsonGame["release"] = game.release
				jsonGame["publisher"] = game.publisher
				truncatedGames.push jsonGame
			end
			return truncatedGames
		end

		def selective_clone_users(users)
			truncatedUsers = []
			users.each do |user|
				jsonUser = {}
				jsonUser["id"] = user.id
				jsonUser["name"] = user.name
				truncatedUsers.push jsonUser
			end
			return truncatedUsers
		end
	end
end
