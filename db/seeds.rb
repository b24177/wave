# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "deleting prior records"
User.delete_all
Artist.delete_all
Content.delete_all
Post.delete_all


puts 'Creating users...'

user1 = User.create!({
   email: 'testUser@gmail.com',
  password: 'password'
})

artist1 = Artist.create!({
  name: 'Lust for Youth',
  location: 'Copenhagen',
  spotify_id: 1234,
  facebook_id: 5678,
})

post1 = Post.create!({
artist: artist1,
source: 'Facebook'
})

content1 = Content.create! ({
  format: 'text',
  data: 'Listen to my new song',
  post: post1
})
