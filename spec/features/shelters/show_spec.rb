require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit a shelters show page' do
		before :each do
			@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: "80230")
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
			
			@freja = @ddfl.pets.create!(image: "https://thehappypuppysite.com/wp-content/uploads/2018/08/great-pyrenees-long.jpg", name: "Freja", description: "Great Perinnes", age: 3, sex: "Female", adoptable: true)
			@ciri = @ddfl.pets.create!(image: "https://www.thelabradordog.com/wp-content/uploads/2018/11/Albino-Labrador.png", name: "Ciri", description: "White Lab", age: 2, sex: "Female", adoptable: true)
			@twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", description: "Doxine Mini", age: 7, sex: "Male", adoptable: false)
			
			@review_1 = @ddfl.reviews.create!(title: "Lovely Experience",rating: 5, content: "Very Clean and a helpful staff", image:"https://airpetsamerica.com/wp-content/uploads/2017/02/images-5-1-250x166.jpg")
			@review_2 = @ddfl.reviews.create!(title: "It was Alright",rating: 3, content: "Some what Clean but I don't think they should be using newspaper", image:"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRXF-XffXImF42qhSjwNZUDWeO5SUgCmSNjtF2gwpEBfSC7eC62")
			
			@sebastian = Application.create!(name: "Sebastian", address: "123 Fake st.", city: "Denver", state: "Co", zip: "80230", phone_number: "720 555 7659", description: "I alreayd have two pets in perfect health and happiness at home")
			@ben = Application.create!(name: "Ben", address: "456 Fake St.", city: "Denver", state: "Co.", zip: "80345", phone_number: "303 897 6754", description: "I would make  good pet owner because I care about my pets and feed them daily")

			@freja.applications << @sebastian
			@ciri.applications << @ben
	
			visit "/shelters/#{@ddfl.id}"
		end

		it 'I should see that Shelters name and adress' do
			expect(current_path).to eq("/shelters/#{@ddfl.id}")
			expect(page).to have_link(@ddfl.name)
			expect(page).to have_content(@ddfl.address)
			expect(page).to have_content(@ddfl.city)
			expect(page).to have_content(@ddfl.state)
			expect(page).to have_content(@ddfl.zip)
		end

		it 'I should not see the infromation of other shelters unless the same city, state, or zip' do
			expect(page).not_to have_content(@acph.name)
			expect(page).not_to have_content(@acph.address)
		end

		it 'I should see a link to update the shelters Information' do
			expect(page).to have_link("Update Shelter")

			click_on "Update Shelter"
			expect(current_path).to eq("/shelters/#{@ddfl.id}/edit")
		end

		it 'I should see a link to delete the shelter completely' do
			expect(page).to have_link("Delete Shelter")

			click_on "Delete Shelter"
			expect(current_path).to eq("/shelters")

			expect(page).not_to have_content(@ddfl.name)
			expect(page).not_to have_content(@ddfl.address)
			expect(page).not_to have_content(@ddfl.city)
			expect(page).not_to have_content(@ddfl.zip)
		end

		it 'I should NOT see a link to delete the shelter if any of its pets have a pending status' do
			visit "/shelters/#{@acph.id}"
			expect(page).not_to have_link("Delete Shelter")
		end

		it 'I should not see any pets in the shelter that I have deleted in the pets index page' do
			click_on "Delete Shelter"
			expect(current_path).to eq("/shelters")

			visit "/pets"

			expect(page).not_to have_css("img[src*='#{@freja.image}']")
			expect(page).not_to have_content(@freja.name)
			expect(page).not_to have_content(@freja.age)
			expect(page).not_to have_content(@freja.sex)
			expect(page).not_to have_content(@freja.shelter.name)

			expect(page).not_to have_css("img[src*='#{@ciri.image}']")
			expect(page).not_to have_content(@ciri.name)
			expect(page).not_to have_content(@ciri.age)
			expect(page).not_to have_content(@ciri.sex)
			expect(page).not_to have_content(@ciri.shelter.name)
		end

		it 'I should see a link that takes me to the pet index page for this shelter' do
			expect(page).to have_link("Shelter Pets")

			click_on "Shelter Pets"
			expect(current_path).to eq("/shelters/#{@ddfl.id}/pets")
		end

		it 'I see a list of reviews for that shelter' do
			expect(page).to have_content(@review_1.title)
			expect(page).to have_content("#{@review_1.rating}/5 stars")
			expect(page).to have_content(@review_1.content)
			expect(page).to have_css("img[src*='#{@review_1.image}']")
		end

		it "I see a link next to each review to delete the review" do
			visit "/shelters/#{@ddfl.id}"
			expect(current_path).to eq("/shelters/#{@ddfl.id}")

			within "#review-#{@review_1.id}" do
  			click_link 'Delete Review'
			end

			expect(page).not_to have_content(@review_1.title)
			expect(page).not_to have_content(@review_1.content)
			expect(page).not_to have_css("img[src*='#{@review_1.image}']")
		end

		it 'I see a count of how many pets are in this shelter' do
			expect(page).to have_content("Number of Pets: 2")
		end

		it 'I can see the average rating for the revies on this shelter' do
			expect(page).to have_content("Average Rating: 4.0/5 stars")
		end

		it 'I can see the number of Applications submited for pets in this shelter' do
			expect(page).to have_content("Current Application Count: 2")
		end
	end
end
