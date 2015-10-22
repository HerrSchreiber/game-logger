class CreatePossessions < ActiveRecord::Migration
  def change
    create_table :possessions do |t|
      t.integer :user_id
      t.integer :game_id

      t.timestamps null: false
    end
		add_index :possessions, :user_id
		add_index :possessions, :game_id
		add_index :possessions, [:user_id, :game_id], unique: true
  end
end
