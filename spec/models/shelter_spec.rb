require 'rails_helper'

describe Shelter, type: :model do
	describe 'Validations' do
		it {should validate_presence_of :name}
		it {should validate_presence_of :address}
		it {should validate_presence_of :city}
		it {should validate_presence_of :state}
		it {should validate_presence_of :zip}
	end

	describe 'Relationships' do
		it {should have_many :pets}
	end

	describe "Methods" do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
			@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: "80230")
			
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: false)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: false)
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
			@twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", description: "Doxine Mini", age: 7, sex: "Male")
			@freja = @ddfl.pets.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2018/08/great-pyrenees-long.jpg", name: "Freja", description: "Great Perinnes", age: 3, sex: "Female")
			@ciri = @ddfl.pets.create!(image: "https://www.thelabradordog.com/wp-content/uploads/2018/11/Albino-Labrador.png", name: "Ciri", description: "White Lab", age: 2, sex: "Female")
			
			@sebastian = Application.create!(name: "Sebastian", address: "123 Fake st.", city: "Denver", state: "Co", zip: "80230", phone_number: "720 555 7659", description: "I alreayd have two pets in perfect health and happiness at home")
			@ben = Application.create!(name: "Ben", address: "456 Fake St.", city: "Denver", state: "Co.", zip: "80345", phone_number: "303 897 6754", description: "I would make  good pet owner because I care about my pets and feed them daily")

			@jona.applications << @sebastian
			@twitch.applications << @sebastian
			@twitch.applications << @ben
			@freja.applications << @ben
		end

		it "#pet_pending?" do
			expect(@aps.pets_pending?).to eq(false)
			expect(@acph.pets_pending?).to eq(true)
		end

		it "#application_count" do
			expect(@aps.application_count).to eq(1)
			expect(@acph.application_count).to eq(2)
			expect(@ddfl.application_count).to eq(1)
		end
	end
end
