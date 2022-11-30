# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 49.times do |n|
#     name = Faker::Name.name
#     name = name.split(' ')
#     email = "example-#{n+1}@mail.com"
#     password = "password"
#     User.create!(firstname: name.first,
#                 lastname: name.last,
#                   email: email,
#                   password: password,
#                   password_confirmation: password,
#                   date_of_birth: Time.at(rand(Time.parse('1960-1-1').to_i..Time.parse('2010-1-1').to_i))  ,
#                   gender: "Male")
#     end
# 249.times do |n|
#  Post.create!(content: Faker::Quote.famous_last_words,
#                 user_id: rand(1..54))

#  end 
# 2000.times do |n|   
# user = User.all.sample(1)
# post = Post.all.sample(1)
# user[0].likes post[0]
# post[0].update(likes_count: post[0].get_likes.size)
# end
