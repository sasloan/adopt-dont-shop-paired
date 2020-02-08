require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit the shelters index page' do
		before :each do
			@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: "80230")
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			visit '/shelters'
		end

		it "I can see the shelters name's and address's" do

			expect(current_path).to eq('/shelters')

			within "#shelter-#{@ddfl.id}" do
				expect(page).to have_content(@ddfl.name)
				expect(page).to have_content(@ddfl.address)
				expect(page).to have_content(@ddfl.city)
				expect(page).to have_content(@ddfl.state)
				expect(page).to have_content(@ddfl.zip)
			end

			within "#shelter-#{@acph.id}" do
				expect(page).to have_content(@acph.name)
				expect(page).to have_content(@acph.address)
				expect(page).to have_content(@acph.city)
				expect(page).to have_content(@acph.state)
				expect(page).to have_content(@acph.zip)
			end

			within "#shelter-#{@aps.id}" do
				expect(page).to have_content(@aps.name)
				expect(page).to have_content(@aps.address)
				expect(page).to have_content(@aps.city)
				expect(page).to have_content(@aps.state)
				expect(page).to have_content(@aps.zip)
			end
		end

		it 'There is a link that I can click on to Create a new Shelter' do

			expect(current_path).to eq("/shelters")

			expect(page).to have_link("New Shelter")

			click_on "New Shelter"

			expect(current_path).to eq("/shelters/new")
		end

		it 'There is a link next to each shelter that allows me to update the shelters information' do

			expect(current_path).to eq("/shelters")

			within"#shelter-#{@ddfl.id}" do
			expect(page).to have_link("Update Shelter")

			click_on "Update Shelter"

			expect(current_path).to eq("/shelters/#{@ddfl.id}/edit")
			end
		end

		it 'There is a link next to each shelter that allows me to delete the shelters information' do

			expect(current_path).to eq("/shelters")

			within"#shelter-#{@ddfl.id}" do
			expect(page).to have_link("Delete Shelter")

			click_on "Delete Shelter"

			expect(current_path).to eq("/shelters")
			end

			expect(page).not_to have_content(@ddfl.name)
			expect(page).not_to have_content(@ddfl.address)
		end

		it 'The name of the shelter is a link to its show page' do

			expect(current_path).to eq("/shelters")

			within"#shelter-#{@ddfl.id}" do
				expect(page).to have_link(@ddfl.name)

				click_on "#{@ddfl.name}"

				expect(current_path).to eq("/shelters/#{@ddfl.id}")
			end
		end
	end
end
