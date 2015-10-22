class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :release
      t.string :publisher
      t.string :platform

      t.timestamps null: false
    end
		add_index :games, [:title, :platform], unique: true
  end
end
