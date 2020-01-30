# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Shelters
@mikes = Shelter.create!(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")
@megs = Shelter.create!(name: "Meg's Shelter", address: "150 Main Street ", city: "Hershey", state: "PA", zip: "17033")
# @ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: "80230")
# @acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
# @aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")

# Pets

@athena = @mikes.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female")
@odell = @megs.pets.create!(name: "Odell", description: "good dog", age: 4, sex: "male")
# @jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
# @ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
# @twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", description: "Doxine Mini", age: 7, sex: "Male")
# @freja = @ddfl.pets.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2018/08/great-pyrenees-long.jpg", name: "Freja", description: "Great Perinnes", age: 3, sex: "Female")
# @ciri = @ddfl.pets.create!(image: "https://www.thelabradordog.com/wp-content/uploads/2018/11/Albino-Labrador.png", name: "Ciri", description: "White Lab", age: 2, sex: "Female")
# @maggie = @acph.pets.create!(name: "Maggie", description: "Black Lab", age: 14, sex: "Female")
