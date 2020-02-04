require 'rails_helper'

describe 'As a Visitor' do
	describe "When a visitor adds pets to their favorites page" do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")
		end

	  it "displays a message" do

	    visit "/pets/#{@jona.id}"

	    click_button "Add Pet To Favorites"

			expect(current_path).to eq("/pets/#{@jona.id}")
	    expect(page).to have_content("#{@jona.name} has been added to your favorites")
	  end

		describe 'I can add multiple Pets to my favorites page' do

			it 'I can see all the pets in my favorites page' do

				visit "/pets/#{@jona.id}"

				click_button "Add Pet To Favorites"

				expect(current_path).to eq("/pets/#{@jona.id}")
				expect(page).to have_content("#{@jona.name} has been added to your favorites")

				visit "/pets/#{@ozzy.id}"

				click_button "Add Pet To Favorites"

				expect(current_path).to eq("/pets/#{@ozzy.id}")
				expect(page).to have_content("#{@ozzy.name} has been added to your favorites")
			end
		end
	end
end
