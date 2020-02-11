require 'rails_helper'

describe 'As a Visitor' do
	describe 'In the navigation bar at the top of all pages' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: false)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: false)
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
		end

		it 'I should be able to click a link to go to the pets index page' do
			visit "/shelters"
			expect(current_path).to eq("/shelters")
			expect(page).to have_link("Pets")

			click_on "Pets"

			expect(current_path).to eq("/pets")
		end

		it 'I should be able to click a link to go to the shelters index page' do
			visit "/pets"
			expect(current_path).to eq("/pets")
			expect(page).to have_link("Shelters")

			click_on "Shelters"

			expect(current_path).to eq("/shelters")
		end

		it 'I should be able to see a link to favorites and see how many pets are favorited' do
			visit "/pets"
			expect(current_path).to eq("/pets")
			expect(page).to have_link("Favorites: 0")

			click_on "Favorites: 0"

			expect(current_path).to eq("/favorites")
		end

		it 'I can see the number of pets displayed on the nav bar' do
			visit "/pets/#{@jona.id}"
			expect(page).to have_content("Favorites: 0")

			visit "/pets/#{@jona.id}"
			click_button "Add Pet To Favorites"

			expect(current_path).to eq("/pets/#{@jona.id}")
			expect(page).to have_content("#{@jona.name} has been added to your favorites")
			expect(page).to have_content("Favorites: 1")

			visit "/pets/#{@ozzy.id}"
			click_button "Add Pet To Favorites"

			expect(current_path).to eq("/pets/#{@ozzy.id}")
			expect(page).to have_content("#{@ozzy.name} has been added to your favorites")
			expect(page).to have_content("Favorites: 2")
		end
	end
end
