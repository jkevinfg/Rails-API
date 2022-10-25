# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(email: "jair@gmail.com", name:"Jair")
User.create!(email: "kevin@gmail.com", name:"Kevin")
User.create!(email: "diana@gmail.com", name:"Diana")

(1..20).each do |id|
  Post.create!(title: "Post: #{id}",
               content: Faker::Lorem.paragraph,
               published: [true, false].sample,
               user_id: User.order('RANDOM()').last.id )
end