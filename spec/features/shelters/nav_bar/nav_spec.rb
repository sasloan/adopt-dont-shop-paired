require 'rails_helper'

describe 'As a Visitor' do
	describe 'In the navigation bar at the top of all pages' do
		it 'I should be able to click a link to go to the pets index page' do

			visit "/shelters"

			expect(current_path).to eq("/shelters")

			expect(page).to have_link("Pets")

			click_on "Pets"

			expect(current_path).to eq("/pets")
		end
	end
end
