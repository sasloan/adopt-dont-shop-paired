require 'rails_helper'

describe Review, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :title}
		it {should validate_presence_of :rating}
		it {should validate_presence_of :content}
  end

  describe 'Relationships' do
    it {should belong_to :shelter}
  end

	describe "Methods" do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: false)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: false)
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
			@review_1 = @aps.reviews.create!(title: "Lovely Experience",rating: 5, content: "Very Clean and a helpful staff", image:"https://airpetsamerica.com/wp-content/uploads/2017/02/images-5-1-250x166.jpg")
			@review_2 = @aps.reviews.create!(title: "It was Alright",rating: 3, content: "Some what Clean but I don't think they should be using newspaper", image:"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRXF-XffXImF42qhSjwNZUDWeO5SUgCmSNjtF2gwpEBfSC7eC62")
		end

		it "#average_rating" do
			expect(Review.average_rating).to eq(4)
		end
	end
end
