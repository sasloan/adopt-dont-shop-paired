require 'rails_helper'

describe 'As a Visitor' do
	describe 'After I have added pets to my favorites' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female")
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: true)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: true)
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male")

			visit "/pets/#{@jona.id}"
			click_on "Add Pet To Favorites"

			visit "/pets/#{@cricket.id}"
			click_on "Add Pet To Favorites"
			
			visit "/pets/#{@athena.id}"
			click_on "Add Pet To Favorites"
			
			visit "/pets/#{@ozzy.id}"
			click_on "Add Pet To Favorites"
			expect(page).to have_content("#{@ozzy.name} has been added to your favorites")

			visit "/favorites"
		end

		it "I should see a list of all the favorited pets and their information" do
			expect(current_path).to eq("/favorites")

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_link(@jona.name)

			expect(page).to have_css("img[src*='#{@cricket.image}']")
			expect(page).to have_link(@cricket.name)

			expect(page).to have_css("img[src*='#{@athena.image}']")
			expect(page).to have_link(@athena.name)

			expect(page).to have_css("img[src*='#{@ozzy.image}']")
			expect(page).to have_link(@ozzy.name)
		end

		it 'I should see a remove from favorites option within each pet' do
			expect(current_path).to eq("/favorites")

			within"#pet-#{@jona.id}" do
				expect(page).to have_link("Remove Pet")
				
				click_on "Remove Pet"
				expect(current_path).to eq("/favorites")
			end

			expect(page).not_to have_css("img[src*='#{@jona.image}']")
		end

		it 'I see a message that I have no favorites if the favorites is empty' do
			expect(current_path).to eq("/favorites")

			within"#pet-#{@jona.id}" do
				expect(page).to have_link("Remove Pet")

				click_on "Remove Pet"
				expect(current_path).to eq("/favorites")
			end

			within"#pet-#{@cricket.id}" do
				expect(page).to have_link("Remove Pet")

				click_on "Remove Pet"
				expect(current_path).to eq("/favorites")
			end

			within"#pet-#{@athena.id}" do
				expect(page).to have_link("Remove Pet")

				click_on "Remove Pet"
				expect(current_path).to eq("/favorites")
			end

			within"#pet-#{@ozzy.id}" do
				expect(page).to have_link("Remove Pet")

				click_on "Remove Pet"
				expect(current_path).to eq("/favorites")
			end

			expect(current_path).to eq("/favorites")
			expect(page).to have_content("You have no favorites!")
		end

		it 'I have a button that I can push to erase all of the pets in my favorites' do
			expect(current_path).to eq("/favorites")

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_link(@jona.name)

			expect(page).to have_css("img[src*='#{@cricket.image}']")
			expect(page).to have_link(@cricket.name)

			expect(page).to have_css("img[src*='#{@athena.image}']")
			expect(page).to have_link(@athena.name)

			expect(page).to have_css("img[src*='#{@ozzy.image}']")
			expect(page).to have_link(@ozzy.name)

			click_on "Remove All Pets"
			expect(current_path).to eq("/favorites")
			expect(page).to have_content("All pets have been removed from your favorites.")
		end
		
		it "After I've created applications, I see a list of pets w/ at least one application" do
			click_link "Apply To Adopt"
			
			within "#favorite-#{@jona.id}" do
        check "check_box[]"
      end
      
      within "#favorite-#{@cricket.id}" do
        check "check_box[]"
      end
			
			fill_in :name, with: "Ben Fox"
      fill_in :address, with: "123 Cool St"
      fill_in :city, with: "West Chester"
      fill_in :state, with: "OK"
      fill_in :zip, with: "11223"
      fill_in :phone_number, with: "123-456-7890"
      fill_in :description, with: "I love to spoil my pets."
			
			click_button "Create Application"
			visit "/pets/#{@jona.id}"
			click_button "Add Pet To Favorites"
			visit "/favorites"
			click_link "Apply To Adopt"
			
			within "#favorite-#{@jona.id}" do
        check "check_box[]"
      end
			
			fill_in :name, with: "Syd Barrett"
      fill_in :address, with: "453 Loco St"
      fill_in :city, with: "Norman"
      fill_in :state, with: "OK"
      fill_in :zip, with: "88334"
      fill_in :phone_number, with: "987-654-3210"
      fill_in :description, with: "Pets are a big responsibility that I take seriously."
			
			click_button "Create Application"
			expect(current_path).to eq("/favorites")
			
			within "#applied_for" do
				expect(page).to have_link("#{@jona.name}", count: 1)
				expect(page).to have_link("#{@cricket.name}")
			end
		end
		
		it "After I've deleted a pet, it's removed from favorites" do
			visit "/pets/#{@ozzy.id}"
			click_link "Delete Pet"
			visit "/favorites"
			
			expect(page).not_to have_link(@ozzy.name)
		end
		
		it "I can see the list of approved applications on the favorites index page" do
			application_1 = @jona.applications.create!(name: "John Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-6543", description: "Good home")
			application_2 = @cricket.applications.create!(name: "Jane Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-6543", description: "Good home")
			application_3 = @athena.applications.create!(name: "Jackson Doe", address: "123 Arf St", city: "New York", state: "NY", zip: "38567", phone_number: "374-747-6543", description: "Good home")
			
			pet_application = PetApplication.where(pet_id: @jona.id, application_id: application_1.id).first
			pet_application.update(approved: true)
			
			pet_application = PetApplication.where(pet_id: @cricket.id, application_id: application_2.id).first
			pet_application.update(approved: true)
			
			visit "/favorites"
			
			within "#approved" do
				expect(page).to have_link(@jona.name)
				expect(page).to have_link(@cricket.name)
				expect(page).not_to have_link(@athena.name)
			end
		end
	end
end
