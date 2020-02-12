require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit the shelters index page' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: false)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: false)
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
			@twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", description: "Doxine Mini", age: 7, sex: "Male", adoptable: false)
			@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: "80230")
			@freja = @ddfl.pets.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2018/08/great-pyrenees-long.jpg", name: "Freja", description: "Great Perinnes", age: 3, sex: "Female")
			@ciri = @ddfl.pets.create!(image: "https://www.thelabradordog.com/wp-content/uploads/2018/11/Albino-Labrador.png", name: "Ciri", description: "White Lab", age: 2, sex: "Female")

			visit '/shelters'
			expect(current_path).to eq("/shelters")
		end

		it "I can see the shelters names and addresses" do
			within "#shelter-#{@ddfl.id}" do
				expect(page).to have_link(@ddfl.name)
				expect(page).to have_content(@ddfl.address)
				expect(page).to have_content(@ddfl.city)
				expect(page).to have_content(@ddfl.state)
				expect(page).to have_content(@ddfl.zip)
			end

			within "#shelter-#{@acph.id}" do
				expect(page).to have_link(@acph.name)
				expect(page).to have_content(@acph.address)
				expect(page).to have_content(@acph.city)
				expect(page).to have_content(@acph.state)
				expect(page).to have_content(@acph.zip)
			end

			within "#shelter-#{@aps.id}" do
				expect(page).to have_link(@aps.name)
				expect(page).to have_content(@aps.address)
				expect(page).to have_content(@aps.city)
				expect(page).to have_content(@aps.state)
				expect(page).to have_content(@aps.zip)
			end
		end

		it 'There is a link that I can click on to Create a new Shelter' do
			expect(page).to have_link("New Shelter")

			click_on "New Shelter"
			expect(current_path).to eq("/shelters/new")
		end

		it 'There is a link next to each shelter that allows me to update the shelters information' do
			within"#shelter-#{@ddfl.id}" do
				expect(page).to have_link("Update Shelter")

				click_on "Update Shelter"
				expect(current_path).to eq("/shelters/#{@ddfl.id}/edit")
			end
		end

		it 'There is a link next to each shelter that allows me to delete the shelters information' do
			within"#shelter-#{@ddfl.id}" do
				expect(page).to have_link("Delete Shelter")

				click_on "Delete Shelter"
				expect(current_path).to eq("/shelters")
			end

			expect(page).not_to have_link(@ddfl.name)
			expect(page).not_to have_content(@ddfl.address)
		end

		it 'I should NOT see a link to delete the shelter if any of its pets have a pending status' do
			within "#shelter-#{@acph.id}" do
				expect(page).not_to have_link("Delete Shelter")
			end
		end

		it 'I should not see any pets in the shelter that I have deleted in the pets index page' do
			within "#shelter-#{@ddfl.id}" do
				click_on "Delete Shelter"
				expect(current_path).to eq("/shelters")
			end

			visit "/pets"

			expect(page).not_to have_css("img[src*='#{@freja.image}']")
			expect(page).not_to have_link(@freja.name)
			expect(page).not_to have_css("img[src*='#{@ciri.image}']")
			expect(page).not_to have_link(@ciri.name)
		end

		it 'The name of the shelter is a link to its show page' do
			within"#shelter-#{@ddfl.id}" do
				expect(page).to have_link(@ddfl.name)

				click_on "#{@ddfl.name}"
				expect(current_path).to eq("/shelters/#{@ddfl.id}")
			end
		end
	end
end
