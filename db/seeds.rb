# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(name: 'María', profile_photo: 'https://th.bing.com/th/id/R5247a39318e0218f12d59f4ca5a61a8f?rik=QOaw8rwC2iStpA&riu=http%3a%2f%2ftusimagenesde.com%2fwp-content%2fuploads%2f2016%2f04%2funa-mujer-6.jpg&ehk=Df%2f86Wyvrkw6OkErdlF%2bSuZKagukIYw7n1SPezzCzjg%3d&risl=&pid=ImgRaw', email:'maria@maria.com', password: '123456')

100.times do |i|
  Tweet.create(content:"Contenido#{i}", user_id:u.id)
end
