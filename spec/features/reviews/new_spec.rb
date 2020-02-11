require 'rails_helper'

describe 'As a visitor' do
  describe "when I click Add Review from a shelter's show page" do
    before :each do
      @acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
      @content = "The people at this shelter were so kind and helpful."
      @image = "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2018/06/kittens-in-shelter-69469.jpg?h=ece64c50&itok=tOiKeqHY"
      
      visit "/shelters/#{@acph.id}"
      click_link 'Add Review'
      expect(current_path).to eq("/shelters/#{@acph.id}/reviews/new")
      
      expect(page).to have_content("Title")
			expect(page).to have_content("Rating (1-5)")
			expect(page).to have_content("Content")
			expect(page).to have_content("Image")
    end
    
    it "I'm taken to a new page to fill out a form with the info and can create a new review" do
			fill_in :title, with: "Wonderful experience"
			fill_in :rating, with: "5"
			fill_in :content, with: @content
			fill_in :image, with: @image

			click_button 'Add Review'

			expect(current_path).to eq("/shelters/#{@acph.id}")

			expect(page).to have_content("Wonderful experience")
			expect(page).to have_content("5/5 stars")
			expect(page).to have_content(@content)
			expect(page).to have_css("img[src*='#{@image}']")
    end
    
    it "I'm taken to a new page to fill out a form with the info and can create a new review without an image" do
			fill_in :title, with: "Wonderful experience"
			fill_in :rating, with: "5"
			fill_in :content, with: @content

			click_button 'Add Review'
      
			expect(current_path).to eq("/shelters/#{@acph.id}")

      new_review = Review.last

			expect(page).to have_content("Wonderful experience")
			expect(page).to have_content("5/5 stars")
			expect(page).to have_content(@content)
			expect(page).to have_css("img[src*='#{new_review.image}']")
    end
    
    it "I cannot create a review without the required information" do
      click_button 'Add Review'

      expect(page).to have_content("Must fill in title, rating and content.")
      expect(page).to have_button('Add Review')
    end
  end
end