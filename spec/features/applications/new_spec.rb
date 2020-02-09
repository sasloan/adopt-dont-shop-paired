require 'rails_helper'

describe 'As a visitor' do
  describe "After I've added pets to my favorites list" do
    before :each do
      @aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
      
      @jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: true)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: true)
      
      visit "/pets/#{@jona.id}"

			expect(current_path).to eq("/pets/#{@jona.id}")
			click_on "Add Pet To Favorites"
			expect(current_path).to eq("/pets/#{@jona.id}")
			expect(page).to have_content("#{@jona.name} has been added to your favorites")

			visit "/pets/#{@cricket.id}"

			expect(current_path).to eq("/pets/#{@cricket.id}")
			click_on "Add Pet To Favorites"
			expect(current_path).to eq("/pets/#{@cricket.id}")
			expect(page).to have_content("#{@cricket.name} has been added to your favorites")

			visit "/pets/#{@athena.id}"

			expect(current_path).to eq("/pets/#{@athena.id}")
			click_on "Add Pet To Favorites"
			expect(current_path).to eq("/pets/#{@athena.id}")
			expect(page).to have_content("#{@athena.name} has been added to your favorites")
      
      visit "/favorites"
    end
    
    it "I can click a link for adopting favorited pets, and select which favorites I want, then apply for them" do
      click_link "Apply To Adopt"
      
      within "#favorite-#{@jona.id}" do
        check "check_box[]"
        expect(page).to have_checked_field("check_box[]")
      end
      
      within "#favorite-#{@cricket.id}" do
        check "check_box[]"
        expect(page).to have_checked_field("check_box[]")
      end
      
      expect(current_path).to eq("/favorites/applications/new")
      expect(page).to have_content("#{@jona.name}")
      expect(page).to have_content("#{@cricket.name}")
      expect(page).to have_content("#{@athena.name}")
      
      expect(page).to have_content("Name")
      expect(page).to have_content("Address")
      expect(page).to have_content("City")
      expect(page).to have_content("State")
      expect(page).to have_content("Zip")
      expect(page).to have_content("Why my home would be great:")
      
      fill_in :name, with: "Ben Fox"
      fill_in :address, with: "123 Cool St"
      fill_in :city, with: "West Chester"
      fill_in :state, with: "OK"
      fill_in :zip, with: "11223"
      fill_in :phone_number, with: "123-456-7890"
      fill_in :description, with: "I love to spoil my pets"

      click_button "Create Application"
      
      expect(current_path).to eq("/favorites")
      
      expect(page).to have_content("Application accepted for Jona Bark and Cricket.")
      
      expect(page).not_to have_content("#pet-#{@jona.id}")
      expect(page).not_to have_content("#pet-#{@cricket.id}")
    end
  end
end