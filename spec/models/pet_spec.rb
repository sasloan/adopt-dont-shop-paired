require 'rails_helper'

describe Pet, type: :model do
	describe 'Validations' do
		it {should validate_presence_of :name}
		it {should validate_presence_of :description}
		it {should validate_presence_of :age}
		it {should validate_presence_of :sex}
	end

	describe 'Relationships' do
		it {should belong_to :shelter}
	end

	describe 'class methods' do
		it '.pet_count' do
			aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			jona = aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			ozzy = aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")

			expect(Pet.pet_count).to eq(2)
		end
	end
end
