require 'rails_helper'

describe "As a visitor" do
  describe "When I see a pets show page, I click a link to see all of their applications" do
    before :each do
      @aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
      @jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
      @athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: true)
      @application_1 = @jona.applications.create!(name: "John Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-5842", description: "Good home")
      @application_2 = @jona.applications.create!(name: "Jane Doe", address: "456 Meow St", city: "Detroit", state: "MI", zip: "33355", phone_number: "374-747-3432", description: "Great home")
      
      visit "/pets/#{@jona.id}"
      click_link "Applications"
    end
    
    it "I see a list of names for all the applicants for that pet, and those names are links to their application show page" do
      expect(current_path).to eq("/pets/#{@jona.id}/applications")
      expect(page).to have_content("Applications for #{@jona.name}")
      expect(page).to have_link(@application_1.name)
      expect(page).to have_link(@application_2.name)
      
      click_link "#{@application_1.name}"
      expect(current_path).to eq("/applications/#{@application_1.id}")
    end
    
    it "If there are no applications I see a message confirming that" do
      visit "/pets/#{@athena.id}"
      click_link "Applications"
      
      expect(page).to have_content("There are no applications for this pet yet.")
    end
  end
end