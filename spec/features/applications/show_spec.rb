require 'rails_helper'

describe "As a visitor" do
  describe "When I visit the application show page"
    before :each do
      @aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
      @jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
      @application = @jona.applications.create!(name: "John Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-5842", description: "Good home")
      @application_2 = @jona.applications.create!(name: "Sebastian Sloan", address: "123 6th Ave", city: "Erie", state: "CO", zip: "76455", phone_number: "374-747-4536", description: "Loving home")
      
      visit "/applications/#{@application.id}"
    end
    
    it "I see all the applicants info, plus the pets the application is for, which are links to their show page" do
      expect(current_path).to eq("/applications/#{@application.id}")
      
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
    
    it "I can approve an application for that pet" do
      within "#pet-#{@jona.id}" do
        click_link "Approve"
      end
      
      expect(current_path).to eq("/pets/#{@jona.id}")
      expect(page).to have_content("This pet is Pending")
      expect(page).to have_content("on hold for #{@application.name}")
    end
    
    it "I can upapprove an application for that pet" do
      within "#pet-#{@jona.id}" do
        click_link "Approve"
      end
      
      visit "/applications/#{@application.id}"
      
      within "#pet-#{@jona.id}" do
        expect(page).not_to have_link("Approve")
        click_link "Unapprove"
      end
      
      expect(current_path).to eq("/applications/#{@application.id}")
      
      within "#pet-#{@jona.id}" do
        expect(page).not_to have_link("Unapprove")
        expect(page).to have_link("Approve")
      end
      
      visit "/pets/#{@jona.id}"
      expect(page).to have_content("Status: Adoptable")
      expect(page).not_to have_content("on hold for #{@application.name}")
    end
    
    it "Pets can only have one application approved at a time" do
      within "#pet-#{@jona.id}" do
        click_link "Approve"
      end
      
      visit "/applications/#{@application_2.id}"
      
      within "#pet-#{@jona.id}" do
        expect(page).not_to have_link("Approve")
        expect(page).not_to have_link("Unapprove")
      end
    end
    
    it "You can approve more than one pet application per single application" do
      odell = @aps.pets.create!(name: "Odell", description: "good dog", age: 4, sex: "male")
      PetApplication.create!(pet_id: odell.id, application_id: @application.id)
      
      within "#pet-#{@jona.id}" do
        click_link "Approve"
      end
      
      visit "/applications/#{@application.id}"
      
      within "#pet-#{odell.id}" do
        click_link "Approve"
      end
      
      visit "/applications/#{@application.id}"
      
      within "#pet-#{@jona.id}" do
        expect(page).to have_link("Unapprove")
      end
      
      within "#pet-#{odell.id}" do
        expect(page).to have_link("Unapprove")
      end
    end
end