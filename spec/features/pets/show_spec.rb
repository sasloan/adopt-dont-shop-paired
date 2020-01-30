require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit a specific pets show page' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: 80003)
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", approximate_age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", approximate_age: 4, sex: "Male")
		end

		it 'I should see the pets name, image, approximate_age, sex and adoptable status' do

			visit "/pets/#{@jona.id}"

			expect(current_path).to eq("/pets/#{@jona.id}")

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.approximate_age)
			expect(page).to have_content(@jona.sex)
			expect(page).to have_content("This pet is available to adopt")
		end
	end
end
