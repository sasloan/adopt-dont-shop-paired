require 'rails_helper'

describe 'As a Visitor' do
	describe 'After I have added pets to my favorites' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: true)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: true)
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")

			visit "/pets/#{@jona.id}"

			expect(current_path).to eq("/pets/#{@jona.id}")
			click_on "Add Pet To Favorites"
			expect(current_path).to eq("/pets/#{@jona.id}")
			expect(page).to have_content("#{@jona.name} has been added to your favorites")

			visit "/pets/#{@cricket.id}"

			expect(current_path).to eq("/pets/#{@cricket.id}")
			click_on "Add Pet To Favorites"
			expect(current_path).to eq("/pets/#{@cricket.id}")
			expect(page).to have_content("#{@cricket.name} has been added to your favorites")

			visit "/pets/#{@athena.id}"

			expect(current_path).to eq("/pets/#{@athena.id}")
			click_on "Add Pet To Favorites"
			expect(current_path).to eq("/pets/#{@athena.id}")
			expect(page).to have_content("#{@athena.name} has been added to your favorites")

			visit "/pets/#{@ozzy.id}"

			expect(current_path).to eq("/pets/#{@ozzy.id}")
			click_on "Add Pet To Favorites"
			expect(current_path).to eq("/pets/#{@ozzy.id}")
			expect(page).to have_content("#{@ozzy.name} has been added to your favorites")

			visit "/favorites"
		end

		it "I should see a list of all the favorited pets and their information" do

			expect(current_path).to eq("/favorites")

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_link(@jona.name)

			expect(page).to have_css("img[src*='#{@cricket.image}']")
			expect(page).to have_link(@cricket.name)

			expect(page).to have_css("img[src*='#{@athena.image}']")
			expect(page).to have_link(@athena.name)

			expect(page).to have_css("img[src*='#{@ozzy.image}']")
			expect(page).to have_link(@ozzy.name)
		end

		it 'I should see a remove from favorites option within each pet' do

			expect(current_path).to eq("/favorites")

			within"#pet-#{@jona.id}" do
				expect(page).to have_button("Remove Pet")

				click_on "Remove Pet"

				expect(current_path).to eq("/favorites")
			end

			expect(page).not_to have_css("img[src*='#{@jona.image}']")
			expect(page).not_to have_content(@jona.name)
		end
	end
end
