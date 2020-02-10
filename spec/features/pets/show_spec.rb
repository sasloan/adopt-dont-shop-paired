require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit a specific pets show page' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
			
			visit "/pets/#{@jona.id}"
		end

		it 'I should see the pets name, image, age, sex and adoptable status' do

			expect(current_path).to eq("/pets/#{@jona.id}")

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.age)
			expect(page).to have_content(@jona.sex)
			expect(page).to have_content("Status: Adoptable")
		end

		it 'I should see a link to edit the pets information' do

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.age)
			expect(page).to have_content(@jona.sex)
			expect(page).to have_content("Status: Adoptable")

			expect(current_path).to eq("/pets/#{@jona.id}")

			expect(page).to have_link("Update Pet")

			click_on "Update Pet"

			expect(current_path).to eq("/pets/#{@jona.id}/edit")
		end

		it 'I can see a button to Delete this Pet' do

			expect(current_path).to eq("/pets/#{@jona.id}")

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.age)
			expect(page).to have_content(@jona.sex)
			expect(page).to have_content("Status: Adoptable")

			expect(page).to have_link("Delete Pet")

			click_on "Delete Pet"

			expect(current_path).to eq("/pets")

			expect(page).not_to have_css("img[src*='#{@jona.image}']")
			expect(page).not_to have_content(@jona.name)
		end

		it "I see a button to add my pet to favorites and when I click it I see that it has been added in the nav bar." do

		 click_button "Add Pet To Favorites"

		 expect(current_path).to eq("/pets/#{@jona.id}")
		 expect(page).to have_content("#{@jona.name} has been added to your favorites")
	 	end

		it "I see a button to remove my pet to favorites and when I click it I see that it has been removed in the nav bar." do

 		 	click_button "Add Pet To Favorites"

 		 	expect(current_path).to eq("/pets/#{@jona.id}")
 		 	expect(page).to have_content("#{@jona.name} has been added to your favorites")

		 	visit "/pets/#{@jona.id}"

		 	click_button "Remove Pet From Favorites"

		 	expect(current_path).to eq("/pets/#{@jona.id}")
		 	expect(page).to have_content("#{@jona.name} has been removed from your favorites")
	 	end

		it "I see the Add to favorites button if my pet is NOT in favorites" do

 		 	click_button "Add Pet To Favorites"

 		 	expect(current_path).to eq("/pets/#{@jona.id}")
 		 	expect(page).to have_content("#{@jona.name} has been added to your favorites")
			expect(page).not_to have_button("Add Pet To Favorites")
		end

		it "I see the Remove From Favorites button if my pet IS in favorites" do

 		 	click_button "Add Pet To Favorites"

 		 	expect(current_path).to eq("/pets/#{@jona.id}")
 		 	expect(page).to have_content("#{@jona.name} has been added to your favorites")
			expect(page).not_to have_button("Add Pet To Favorites")
			expect(page).to have_button("Remove Pet From Favorites")
		end
		
		it "Pet cannot be deleted if it has an approved application" do
			@application = @jona.applications.create!(name: "John Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-5842", description: "Good home")
			
			click_link "Applications"
			click_link "#{@application.name}"
			
			within "#pet-#{@jona.id}" do
        click_link "Approve"
      end
			
			expect(page).not_to have_link("Delete Pet")
		end
	end
end
