class Game < ActiveRecord::Base
	has_many :possessions, dependent: :destroy
	has_many :users, through: :possessions
end
