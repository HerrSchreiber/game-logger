class Possession < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :game_id, presence: true
end
