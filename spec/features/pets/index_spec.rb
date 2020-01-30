require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit the pets index page' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: 80003)
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", approximate_age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", approximate_age: 4, sex: "Male")
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: 80221)
			@twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", description: "Doxine Mini", approximate_age: 7, sex: "Male")
			@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: 80230)
			@freja = @ddfl.pets.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2018/08/great-pyrenees-long.jpg", name: "Freja", description: "Great Perinnes", approximate_age: 3, sex: "Female")
			@ciri = @ddfl.pets.create!(image: "https://www.thelabradordog.com/wp-content/uploads/2018/11/Albino-Labrador.png", name: "Ciri", description: "White Lab", approximate_age: 2, sex: "Female")

			visit '/pets'
		end

		it 'I see a list of all the pets on the website' do

			expect(current_path).to eq('/pets')

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.approximate_age)
			expect(page).to have_content(@jona.sex)
			expect(page).to have_content(@jona.shelter.name)

			expect(page).to have_css("img[src*='#{@ozzy.image}']")
			expect(page).to have_content(@ozzy.name)
			expect(page).to have_content(@ozzy.approximate_age)
			expect(page).to have_content(@ozzy.sex)
			expect(page).to have_content(@ozzy.shelter.name)

			expect(page).to have_css("img[src*='#{@twitch.image}']")
			expect(page).to have_content(@twitch.name)
			expect(page).to have_content(@twitch.approximate_age)
			expect(page).to have_content(@twitch.sex)
			expect(page).to have_content(@twitch.shelter.name)

			expect(page).to have_css("img[src*='#{@freja.image}']")
			expect(page).to have_content(@freja.name)
			expect(page).to have_content(@freja.approximate_age)
			expect(page).to have_content(@freja.sex)
			expect(page).to have_content(@freja.shelter.name)

			expect(page).to have_css("img[src*='#{@ciri.image}']")
			expect(page).to have_content(@ciri.name)
			expect(page).to have_content(@ciri.approximate_age)
			expect(page).to have_content(@ciri.sex)
			expect(page).to have_content(@ciri.shelter.name)
		end
	end
end
