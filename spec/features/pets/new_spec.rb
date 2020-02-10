require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I enter the new form' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
		end

		it 'I see a way to fill in information' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			expect(page).to have_link("Create Pet")

			click_on "Create Pet"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets/new")

			expect(page).to have_content("Image")
			expect(page).to have_content("Name")
			expect(page).to have_content("Description")
			expect(page).to have_content("Age")
			expect(page).to have_content("Sex")

			fill_in :image, with: "https://farm3.static.flickr.com/2114/1639103337_8e077a9dab_o.jpg"
			fill_in :name, with: "Ollie"
			fill_in :description, with: "Half Husky and half Collie"
			fill_in :age, with: 8
			fill_in :sex, with: "Male"

			click_on "Create Pet"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			expect(page).to have_css("img[src*= 'https://farm3.static.flickr.com/2114/1639103337_8e077a9dab_o.jpg']")
			expect(page).to have_content("Ollie")
			expect(page).to have_content("Half Husky and half Collie")
			expect(page).to have_content(8)
			expect(page).to have_content("Male")
		end

		it 'If I dont fill in the infromation then I see a flash message with what required info is missing and stay on the new form' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			expect(page).to have_link("Create Pet")

			click_on "Create Pet"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets/new")

			expect(page).to have_content("Image")
			expect(page).to have_content("Name")
			expect(page).to have_content("Description")
			expect(page).to have_content("Age")
			expect(page).to have_content("Sex")
			
			fill_in :name, with: "Ollie"
			fill_in :description, with: "Half Husky and half Collie"

			click_on "Create Pet"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets/new")
			expect(page).to have_content("You attempted to submit the form without completing required field(s): Age, Sex")
		end
	end
end
