require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I click on the New Shelter link in the shelters index page' do
		before :each do
			visit '/shelters'

			click_on 'New Shelter'
		end

		it 'I am taken to a form to fill in the information of a new pet shelter' do
			expect(current_path).to eq("/shelters/new")

			expect(page).to have_content("Name")
			expect(page).to have_content("Address")
			expect(page).to have_content("City")
			expect(page).to have_content("State")
			expect(page).to have_content("Zip")
			
			fill_in :name, with: "Aurora Pet Clinic"
			fill_in :address, with: "5478 Alameda ave."
			fill_in :city, with: "Aurora"
			fill_in :state, with: "Colorado"
			fill_in :zip, with: "80230"

			click_on 'Create Shelter'
			expect(current_path).to eq("/shelters")

			expect(page).to have_content("Aurora Pet Clinic")
			expect(page).to have_content("5478 Alameda ave.")
			expect(page).to have_content("Aurora")
			expect(page).to have_content("Colorado")
			expect(page).to have_content("80230")
		end

		it 'I am sent to a new form and if I do not fill in required info I get a flash message' do
			click_on "Create Shelter"

			expect(page).to have_content("Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, and Zip can't be blank")
		end
	end
end
