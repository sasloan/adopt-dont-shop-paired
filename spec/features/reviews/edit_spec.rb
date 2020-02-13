require 'rails_helper'

describe 'As a Visitor' do
	describe "When I visit a shelter's show page" do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@review_1 = @aps.reviews.create!(title: "Wonderul experience", rating: "5", content: "The people at this shelter were so kind and helpful.")
			
			visit "/shelters/#{@aps.id}"
      
      within "#review-#{@review_1.id}" do
  			click_link 'Edit Review'
			end
    end

		it 'I can follow a link to edit a review, and submit it with the new info' do
			expect(current_path).to eq("/shelters/#{@aps.id}/reviews/#{@review_1.id}/edit")

			expect(page).to have_content("Title")
			expect(page).to have_content("Rating")
			expect(page).to have_content("Content")
			expect(page).to have_content("Image")

      fill_in :title, with: "Cool place"
			fill_in :rating, with: "4"
			fill_in :content, with: "This is a good shelter, kinda dirty"
			fill_in :image, with: "https://www.austinpetsalive.org/uploads/banners/adopt_banner.jpg"
			
			click_button "Update Review"
			expect(current_path).to eq("/shelters/#{@aps.id}")

			expect(page).to have_content("Cool place")
			expect(page).to have_content("4/5 stars")
			expect(page).to have_content("This is a good shelter, kinda dirty")
			expect(page).to have_css("img[src*='https://www.austinpetsalive.org/uploads/banners/adopt_banner.jpg']")
      
      expect(page).to_not have_content("Wonderul experience")
			expect(page).to_not have_content("5/5 stars")
			expect(page).to_not have_content("The people at this shelter were so kind and helpful.")
		end
		
		it "I can't edit a review if I don't fill out required info" do
			expect(current_path).to eq("/shelters/#{@aps.id}/reviews/#{@review_1.id}/edit")
			
      expect(page).to have_content("Title")
			expect(page).to have_content("Rating (1-5)")
			expect(page).to have_content("Content")
			expect(page).to have_content("Image")
			
			fill_in :rating, with: ""
      click_button 'Update Review'
			
      expect(page).to have_content("Update review not saved: Must fill in title, rating and content.")
      expect(page).to have_button('Update Review')
		end
	end
end