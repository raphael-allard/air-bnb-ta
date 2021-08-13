puts "> Deleting all records..."
User.destroy_all

puts "-------------------------"

puts "> Creating users..."

# BATMAN
batman = User.new(email: "batman@gmail.com", username: "Batman", password: "123456")

file = URI.open("https://img.lemde.fr/2012/07/07/15/292.30846792291/465.35839543596/310.23363729625/688/0/60/0/ill_1729361_c0b3_201207071.0.988834193face_batman_ori.jpg")
batman.avatar.attach(io: file, filename: "avatar", content_type: "image/jpg")
batman.save!

puts "#{batman.username} created!"

# SUPERMAN
superman = User.new(email: "superman@gmail.com", username: "Superman", password: "123456")

file = URI.open("https://i.pinimg.com/originals/cb/9f/37/cb9f37eaf4205b8335d60c6cb91b0925.jpg")
superman.avatar.attach(io: file, filename: "avatar", content_type: "image/jpg")
superman.save!

puts "#{superman.username} created!"

# CATWOMAN
catwoman = User.new(email: "catwoman@gmail.com", username: "Catwoman", password: "123456")

file = URI.open("https://i.pinimg.com/originals/c7/2a/aa/c72aaa5612c6756020d746ae32fbf980.jpg")
catwoman.avatar.attach(io: file, filename: "avatar", content_type: "image/jpg")
catwoman.save!

puts "#{catwoman.username} created!"

puts "-------------------------"

puts "> Creating services..."

def add_photos(service)
  3.times do
    file = URI.open("https://source.unsplash.com/random")
    service.photos.attach(io: file, filename: "photo", content_type: "image/jpg")
    service.save!
  end
end

super_rescue_1 = Service.new(title: "Super Rescue", description: "To book if you are in danger!", price: 299, address: "16 villa Gaudelet, Paris", user: batman)
add_photos(super_rescue_1)
puts "#{super_rescue_1.title} created!"

super_kicker = Service.new(title: "Super Kicker", description: "To book if you want I kick some asses!", price: 59, address: "12 rue de la croix faubin, Paris", user: batman)
add_photos(super_kicker)
puts "#{super_kicker.title} created!"

super_uber = Service.new(title: "Super Uber", description: "To book if you want a cool and badass driver!", price: 39, address: "5 rue erard, Paris", user: superman)
add_photos(super_uber)
puts "#{super_uber.title} created!"

super_escort_1 = Service.new(title: "Super Escort", description: "To book if you are single (or not)!", price: 99, address: "109 rue Saint-Lazare, Paris", user: superman)
add_photos(super_escort_1)
puts "#{super_escort_1.title} created!"

super_rescue_2 = Service.new(title: "Super Rescue", description: "To book if you are in danger!", price: 320, address: "129 Rue de Grenelle, Paris", user: catwoman)
add_photos(super_rescue_2)
puts "#{super_rescue_2.title} created!"

super_swimming = Service.new(title: "Super Swimming", description: "To book if you want to know swimming!", price: 29, address: "78 Avenue des Champs-Elysées, Paris", user: catwoman)
add_photos(super_swimming)
puts "#{super_swimming.title} created!"
