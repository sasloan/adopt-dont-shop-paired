require 'rails_helper'

describe 'As a Visitor' do
	describe 'When I visit a shelters show page' do
		before :each do
			@ddfl = Shelter.create!(name: "Denver Dumb Friends League", address: "1267 Quebec Dr.", city: "Denver", state: "Co.", zip: "80230")
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")

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

		it 'I should see a link to update the shelters Information' do

			expect(current_path).to eq("/shelters/#{@ddfl.id}")

			expect(page).to have_link("Update Shelter")

			click_on "Update Shelter"

			expect(current_path).to eq("/shelters/#{@ddfl.id}/edit")
		end

		it 'I should see a link to delete the shelter completely' do

			expect(current_path).to eq("/shelters/#{@ddfl.id}")

			expect(page).to have_link("Delete Shelter")

			click_on "Delete Shelter"

			expect(current_path).to eq("/shelters")

			expect(page).not_to have_content(@ddfl.name)
			expect(page).not_to have_content(@ddfl.address)
			expect(page).not_to have_content(@ddfl.city)
			expect(page).not_to have_content(@ddfl.zip)
		end

		it 'I should see a link that takes me to the pet index page for this shelter' do

			expect(current_path).to eq("/shelters/#{@ddfl.id}")

			expect(page).to have_link("Shelter Pets")

			click_on "Shelter Pets"

			expect(current_path).to eq("/shelters/#{@ddfl.id}/pets")
		end
		
		it 'I see a list of reviews for that shelter' do
			# Review creation moved out of the before :each because of an issue with deleting reviews when shelter is deleted.
			# I'll deal with it when I get to user story 28, which is that specific requirement.
			content = "The people at this shelter were so kind and helpful."
			image = "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2018/06/kittens-in-shelter-69469.jpg?h=ece64c50&itok=tOiKeqHY"
			
			@review_1 = @ddfl.reviews.create!(title: "Wonderul experience", rating: "5", content: content, image: image)
			
			visit "/shelters/#{@ddfl.id}"
			
			expect(page).to have_content(@review_1.title)
			expect(page).to have_content("#{@review_1.rating}/5 stars")
			expect(page).to have_content(@review_1.content)
			expect(page).to have_css("img[src*='#{@review_1.image}']")
		end
		
		it "I see a link next to each review to delete the review" do
			content = "The people at this shelter were so kind and helpful."
			image = "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2018/06/kittens-in-shelter-69469.jpg?h=ece64c50&itok=tOiKeqHY"
			
			@review_1 = @ddfl.reviews.create!(title: "Wonderul experience", rating: "5", content: content, image: image)
			
			visit "/shelters/#{@ddfl.id}"
			
			within "#review-#{@review_1.id}" do
  			click_link 'Delete Review'
			end
			
			expect(page).not_to have_content(@review_1.title)
			expect(page).not_to have_content("#{@review_1.rating}/5 stars")
			expect(page).not_to have_content(@review_1.content)
			expect(page).not_to have_css("img[src*='#{@review_1.image}']")
		end
	end
end
