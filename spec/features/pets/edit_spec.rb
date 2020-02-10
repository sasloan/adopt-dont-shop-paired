require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I go to a dogs show page and click Update Pet' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
		end

		it 'I am directed to a form to update my dogs infromation' do

			visit "/pets/#{@jona.id}"

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.age)
			expect(page).to have_content(@jona.sex)
			expect(page).to have_content("Status: Adoptable")

			expect(current_path).to eq("/pets/#{@jona.id}")

			expect(page).to have_link("Update Pet")

			click_on "Update Pet"

			expect(current_path).to eq("/pets/#{@jona.id}/edit")

			expect(page).to have_content("Image")
			expect(page).to have_content("Name")
			expect(page).to have_content("Description")
			expect(page).to have_content("Age")
			expect(page).to have_content("Sex")

			fill_in :image, with: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg"
			fill_in :name, with: "New Jona"
			fill_in :description, with: "Pretty Shepherd"
			fill_in :age, with: 9
			fill_in :sex, with: "Female"

			click_on "Update Pet"

			expect(current_path).to eq("/pets/#{@jona.id}")

			expect(page).to have_css("img[src*='https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg']")
			expect(page).to have_content("New Jona")
			expect(page).to have_content("Pretty Shepherd")
			expect(page).to have_content(9)
			expect(page).to have_content("Status: Adoptable")
		end
		
		it 'If I dont fill in the infromation then I see a flash message with what required info is missing and stay on the new form' do

			visit "/pets/#{@jona.id}"

			click_on "Update Pet"

			expect(current_path).to eq("/pets/#{@jona.id}/edit")

			expect(page).to have_content("Image")
			expect(page).to have_content("Name")
			expect(page).to have_content("Description")
			expect(page).to have_content("Age")
			expect(page).to have_content("Sex")
			
			fill_in :name, with: ""
			fill_in :description, with: ""

			click_on "Update Pet"

			expect(current_path).to eq("/pets/#{@jona.id}/edit")
			expect(page).to have_content("You attempted to submit the form without completing required field(s): Name, Description")
		end
	end
end
