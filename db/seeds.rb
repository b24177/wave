# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "deleting prior records"

UserArtist.delete_all
User.delete_all
Artist.delete_all
Content.delete_all
Post.delete_all

user1 = User.create!({
  email: 'testUser@gmail.com',
  password: 'password',
  password_confirmation: 'password'
})

print 'Creating new records'

def create_artist(attributes = {})
  artist = Artist.new({
    name: attributes[:name],
    location: attributes[:location],
    spotify_id: attributes[:location]
  })
  artist.photo.attach(io: File.open(attributes[:file]), filename: attributes[:file], content_type: "image/jpg")
  artist.save!
  artist
end

lust_for_youth = create_artist({
  name: 'Lust for Youth',
  location: 'Copenhagen',
  spotify_id: '18x7cMASHAS2NJ4kcLJa1u',
  file: "app/assets/images/avatars/artist.jpg"
})

def create_post(attributes = {})
  post = Post.create!({
    artist: attributes[:artist],
    source: attributes[:source],
    content: attributes[:content]
  })
  post.photo.attach(io: File.open(attributes[:file]), filename: attributes[:file], content_type: "image/jpg")
  post.save!
  post
end

create_post({
  artist: lust_for_youth,
  source: 'Facebook',
  content: 'Check out our show in London!',
  file: 'app/assets/images/posts/card4.jpg'
})

create_post({
  artist: lust_for_youth,
  source: 'Instagram',
  content: 'We had a great time, Paris!',
  file: 'app/assets/images/posts/card1.jpg'
})

create_post({
  artist: lust_for_youth,
  source: 'Twitter',
  content: 'Mesmerizing...',
  file: 'app/assets/images/posts/card2.jpg'
})
