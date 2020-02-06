require 'rails_helper'

describe 'As a User' do
	describe 'when I visit the shelters pets page' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: "80003")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", age: 4, sex: "Male", adoptable: false)
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", age: 6, sex: "Female", adoptable: true)
			@cricket = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/Breed-Standard-for-a-Black-GSD.jpg", name: "Cricket", description: "Best girl", age: 20, sex: "Female", adoptable: false)
			@athena = @aps.pets.create!(name: "Athena", description: "Butthead", age: 1, sex: "female", adoptable: false)
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: "80221")
			@twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", description: "Doxine Mini", age: 7, sex: "Male")
		end

		it 'I see a list of all the pets in this shelter only' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			within "#pet-#{@jona.id}" do
				expect(page).to have_css("img[src*='#{@jona.image}']")
				expect(page).to have_content(@jona.name)
				expect(page).to have_content(@jona.age)
				expect(page).to have_content(@jona.sex)
			end

			within "#pet-#{@ozzy.id}" do
				expect(page).to have_css("img[src*='#{@ozzy.image}']")
				expect(page).to have_content(@ozzy.name)
				expect(page).to have_content(@ozzy.age)
				expect(page).to have_content(@ozzy.sex)
			end
		end

		it 'I do not see any pets that do not belong in this shelter' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			within "#pet-#{@jona.id}" do
				expect(page).to have_css("img[src*='#{@jona.image}']")
				expect(page).to have_content(@jona.name)
				expect(page).to have_content(@jona.description)
				expect(page).to have_content(@jona.age)
				expect(page).to have_content(@jona.sex)
			end

			within "#pet-#{@ozzy.id}" do
				expect(page).to have_css("img[src*='#{@ozzy.image}']")
				expect(page).to have_content(@ozzy.name)
				expect(page).to have_content(@ozzy.age)
				expect(page).to have_content(@ozzy.sex)
			end

			expect(page).not_to have_css("img[src*='#{@twitch.image}']")
			expect(page).not_to have_content(@twitch.name)
		end

		it 'I see a button to add a new pet to the shelter' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			expect(page).to have_link("Create Pet")

			click_on "Create Pet"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets/new")
		end

		it 'I see an Update Pet link next to each of my pets' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			within "#pet-#{@jona.id}" do
				expect(page).to have_link("Update Pet")

				click_on "Update Pet"

				expect(current_path).to eq("/pets/#{@jona.id}/edit")
			end
		end

		it 'I see an Delete Pet link next to each of my pets' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			within "#pet-#{@jona.id}" do
				expect(page).to have_link("Delete Pet")

				click_on "Delete Pet"

				expect(current_path).to eq("/pets")
			end

			expect(page).not_to have_css("img[src*='#{@jona.image}']")
			expect(page).not_to have_content(@jona.name)
		end

		it 'I can see the pets name is a link to that pets show page' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			within"#pet-#{@jona.id}" do
				expect(page).to have_link(@jona.name)

				click_on "#{@jona.name}"

				expect(current_path).to eq("/pets/#{@jona.id}")
			end
		end

		it 'I see the total number of pets in this shelter' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			expect(page).to have_content("Number of Pets: 4")
		end

		it 'I do not see the total number of pets in the whole website' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			expect(page).not_to have_content("Number of Pets: 5")
		end
	end
end
