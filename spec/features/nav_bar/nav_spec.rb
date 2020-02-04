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
	end
end
