require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit the shelters index page' do
		before :each do
			@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: 80230)
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: 80221)
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: 80003)
			visit '/shelters'
		end

		it "I can see the shelters name's and address's" do

			expect(current_path).to eq('/shelters')

			expect(page).to have_content(@ddfl.name)
			expect(page).to have_content(@ddfl.address)
			expect(page).to have_content(@ddfl.city)
			expect(page).to have_content(@ddfl.state)
			expect(page).to have_content(@ddfl.zip)

			expect(page).to have_content(@acph.name)
			expect(page).to have_content(@acph.address)
			expect(page).to have_content(@acph.city)
			expect(page).to have_content(@acph.state)
			expect(page).to have_content(@acph.zip)

			expect(page).to have_content(@aps.name)
			expect(page).to have_content(@aps.address)
			expect(page).to have_content(@aps.city)
			expect(page).to have_content(@aps.state)
			expect(page).to have_content(@aps.zip)
		end

		it 'There is a button that I can click on to Create a new Shelter' do

			expect(current_path).to eq("/shelters")

			expect(page).to have_link("New Shelter")

			click_on "New Shelter"

			expect(current_path).to eq("/shelters/new")
		end
	end
end
