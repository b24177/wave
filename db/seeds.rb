# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
print "deleting prior records"
UserArtist.delete_all
User.delete_all
Artist.delete_all
Content.delete_all
Post.delete_all


print 'Creating new records'

artist1 = Artist.new({
  name: 'Lust for Youth',
  location: 'Copenhagen',
  spotify_id: '18x7cMASHAS2NJ4kcLJa1u',
  facebook_id: nil
})

artist1.photo.attach(io: File.open("app/assets/images/Artist.jpg"), filename: "Artist", content_type: "image/jpg")
artist1.save

facebook_post = Post.create!({
  artist: artist1,
  source: 'Facebook',
  content: 'Our recent live show!'
})

facebook_post.photo.attach(io: File.open("app/assets/images/postimage.jpg"), filename: "Post Image", content_type: "image/jpg")
facebook_post.save
