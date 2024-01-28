# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


20.times do |i|
  User.create(email: "momo#{i}@gmail.com", name: "momo#{i}", password: "123456", password_confirmation: "123456" )
end

20.times do |i|
  user = User.find(User.ids.sample)
  content = ''
  20.times do |j|
    content = content + Faker::Markdown.emphasis
  end
  Article.create(user: user,name: "Article #{i}", content: content )
end