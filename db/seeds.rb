# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 Admin.create!(
  email:'masakisakumm000@gmail.com',
  password:'masaki0720'
 )
 
 
 olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.png"), filename:"sample-user1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"), filename:"sample-user3.jpg")
end

rpg_genre = Genre.find_or_create_by!(name: "ロールプレイング")
horror_genre = Genre.find_or_create_by!(name: "ホラー")
magic_genre = Genre.find_or_create_by!(name: "アクション")

Post.find_or_create_by!(title: "qest") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/back-alley.jpg"), filename:"back-alley.jpg")
  post_image.introduction = "王道のRPGです。"
  post_image.genre = rpg_genre
  post_image.user = olivia
  post_image.review = 5
end

Post.find_or_create_by!(title: "はろうぃん") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/halloween1.jpg"), filename:"halloween1.jpg")
  post_image.introduction = "凄いこわいです..."
  post_image.genre = horror_genre
  post_image.user = james
  post_image.review = 3
end

Post.find_or_create_by!(title: "magic") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red-magic-circle3.jpg"), filename:"red-magic-circle3.jpg")
  post_image.introduction = '魔法がかっこいい！'
  post_image.genre = magic_genre
  post_image.user = lucas
  post_image.review = 2.5
end