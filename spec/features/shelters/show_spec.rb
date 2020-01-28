require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit a shelters show page' do
		before :each do
			@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: 80230)
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: 80221)
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: 80003)

			visit "/shelters/#{@ddfl.id}"
		end

		it 'I should see that Shelters name and adress' do

			expect(current_path).to eq("/shelters/#{@ddfl.id}")

			expect(page).to have_content(@ddfl.name)
			expect(page).to have_content(@ddfl.address)
			expect(page).to have_content(@ddfl.city)
			expect(page).to have_content(@ddfl.state)
			expect(page).to have_content(@ddfl.zip)
		end

		it 'I should not see the infromation of other shelters unless the same city, state, or zip' do

			expect(current_path).to eq("/shelters/#{@ddfl.id}")

			expect(page).not_to have_content(@acph.name)
			expect(page).not_to have_content(@acph.address)
		end

		it 'I should see a button to update the shelters Information' do

			expect(current_path).to eq("/shelters/#{@ddfl.id}")

			expect(page).to have_link("Update Shelter")

			click_on "Update Shelter"

			expect(current_path).to eq("/shelters/#{@ddfl.id}/edit")
		end
	end
end
