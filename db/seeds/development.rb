User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

20.times do |n|
	title = Faker::App.name + " " + Faker::Number.digit
	release = Faker::Date.backward(10000)
	publisher = Faker::Company.name
	platform = "NES"
	Game.create!(title: title,
	             release: release,
	             publisher: publisher,
	             platform: platform)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Game collections
user = User.all.first
Game.all.each { |game| user.possess(game) }