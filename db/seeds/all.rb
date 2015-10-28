nesGames = JSON.parse(File.read('db/seeds/games/nes.json'));
snesGames = JSON.parse(File.read('db/seeds/games/snes.json'));
genesisGames = JSON.parse(File.read('db/seeds/games/genesis.json'));

[nesGames, snesGames, genesisGames].each do |platformGames|
	platformGames.each do |game|
		title = game["Title"]
		release = game["Release"]
		publisher = game["Publisher"]
		platform = game["Platform"]
		Game.create!(title: title,
								 release: release,
								 publisher: publisher,
								 platform: platform)
	end
end
