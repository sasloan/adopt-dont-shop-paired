require 'rails_helper'

describe "As a visitor" do
  describe "When I visit the application show page"
    before :each do
      @aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
      @jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
      @application = @jona.applications.create!(name: "John Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-5842", description: "Good home")
      
      visit "/applications/#{@application.id}"
      expect(current_path).to eq("/applications/#{@application.id}")
    end
    
    it "I see all the applicants info, plus the pets the application is for, which are links to their show page" do
      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.address)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zip)
      expect(page).to have_content(@application.phone_number)
      expect(page).to have_content(@application.description)
      
      click_link "#{@jona.name}"
      expect(current_path).to eq("/pets/#{@jona.id}")
    end
end