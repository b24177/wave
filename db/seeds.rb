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

print 'Creating new records'

Lust_for_youth = Artist.new({
  name: 'Lust for Youth',
  location: 'Copenhagen',
  spotify_id: '18x7cMASHAS2NJ4kcLJa1u',
  facebook_id: nil
})
def create_post(attributes = {})
  post = Post.create!({
    artist: attributes[:artist],
    source: attributes[:source],
    content: attributes[:content]
  })
  post.photo.attach(io: File.open(attributes[:file]), filename: attributes[:file], content_type: "image/jpg")
  post.save
end

Lust_for_youth.photo.attach(io: File.open("app/assets/images/avatars/artist.jpg"), filename: "Artist", content_type: "image/jpg")
Lust_for_youth.save

create_post({
  artist: Lust_for_youth,
  source: 'Facebook',
  content: 'Our recent live show!',
  file:_"app/assets/images/card4.jpg"
})
create_post({
  artist: nil,
  source: 'Instagram',
  content: nil,
  file:_"app/assets/images/card1.jpg"
})
create_post({
  artist: nil,
  source: 'Twitter',
  content: nil,
  file:_"app/assets/images/card1.jpg"
})
