require 'rails_helper'

describe Pet, type: :model do
	describe 'Validations' do
		it {should validate_presence_of :name}
		it {should validate_presence_of :description}
		it {should validate_presence_of :age}
		it {should validate_presence_of :sex}
	end

	describe 'Relationships' do
		it {should have_many :pet_applications}
		it {should have_many(:applications).through(:pet_applications)}
		it {should belong_to :shelter}
	end

	describe 'Methods' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: false)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: false)
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
		end

		it '#pet_count' do
			expect(Pet.pet_count).to eq(4)
		end
		
		it ".approved_application" do
			application = Application.create!(name: "John Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-6543", description: "Good home")
			pet_application  = PetApplication.create!(pet_id: @jona.id, application_id: application.id, approved: true)
			
			expect(@jona.approved_application).to eq(application)
		end
		
		it ".approved?" do
			application_1 = @jona.applications.create!(name: "John Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-6543", description: "Good home")
			application_2 = @cricket.applications.create!(name: "Jane Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-6543", description: "Good home")
			
			pet_application = PetApplication.where(pet_id: @jona.id, application_id: application_1.id).first
			pet_application.update(approved: true)
			
			expect(@jona.approved?).to eq(true)
			
			pet_application.update(approved:false)
			expect(@jona.approved?).to eq(false)
		end
	end
end
