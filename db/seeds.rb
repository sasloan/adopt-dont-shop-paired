# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.delete_all
PetApplication.delete_all
Application.delete_all
Pet.delete_all
Shelter.delete_all

# Shelters
@mikes = Shelter.create!(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")
@megs = Shelter.create!(name: "Meg's Shelter", address: "150 Main Street ", city: "Hershey", state: "PA", zip: "17033")
@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: "80230")
@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")

# Pets

@athena = @mikes.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female")
@odell = @megs.pets.create!(name: "Odell", description: "good dog", age: 4, sex: "male")
@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: false)
@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
@twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", description: "Doxine Mini", age: 7, sex: "Male", adoptable: false)
@freja = @ddfl.pets.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2018/08/great-pyrenees-long.jpg", name: "Freja", description: "Great Perinnes", age: 3, sex: "Female")
@ciri = @ddfl.pets.create!(image: "https://www.thelabradordog.com/wp-content/uploads/2018/11/Albino-Labrador.png", name: "Ciri", description: "White Lab", age: 2, sex: "Female")
@maggie = @acph.pets.create!(name: "Maggie", description: "Black Lab", age: 14, sex: "Female")

# Reviews

@review_1 = @aps.reviews.create!(title: "Lovely Experience",rating: 5, content: "Very Clean and a helpful staff", image:"https://airpetsamerica.com/wp-content/uploads/2017/02/images-5-1-250x166.jpg")
@review_2 = @aps.reviews.create!(title: "It was Alright",rating: 3, content: "Some what Clean but I don't think they should be using newspaper", image:"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRXF-XffXImF42qhSjwNZUDWeO5SUgCmSNjtF2gwpEBfSC7eC62")
@review_3 = @acph.reviews.create!(title: "Horrible, Cold Puppies",rating: 1, content: "The poor animals where out in the snow!!", image:"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRwTcGTpeMHLn2iEbHfMxo4zeTrTRWw7TlwoWABcxYFX3W4kDQY")
@review_4 = @ddfl.reviews.create!(title: "Absolutley Filthy",rating: 1, content: "This place is the Deffinition of unsanitized", image:"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQi0nRFEj6Lr0uFNzqwDzPp7I4GwBg9ARGvQxk2KSH8_NZA-paG")
@review_5 = @ddfl.reviews.create!(title: "Wonderul experience", rating: "5/5 stars", content: "The people at this shelter were so kind and helpful. They asked specific questions to narrow down what kind of pet would be good for me." , image: "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2018/06/kittens-in-shelter-69469.jpg?h=ece64c50&itok=tOiKeqHY")

# Applications

@application_1 = Application.create!(name: "John Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-6543", description: "Good home")
@application_2 = Application.create!(name: "Sebastian Sloan", address: "123 6th Ave", city: "Erie", state: "CO", zip: "76455", phone_number: "374-747-4536", description: "Loving home")

@pet_application_1 = PetApplication.create!(pet_id: @athena.id, application_id: @application_1.id)
@pet_application_2 = PetApplication.create!(pet_id: @odell.id, application_id: @application_1.id)
@pet_application_3 = PetApplication.create!(pet_id: @jona.id, application_id: @application_1.id)
@pet_application_4 = PetApplication.create!(pet_id: @athena.id, application_id: @application_2.id)
@pet_application_5 = PetApplication.create!(pet_id: @odell.id, application_id: @application_2.id)
@pet_application_6 = PetApplication.create!(pet_id: @jona.id, application_id: @application_2.id)