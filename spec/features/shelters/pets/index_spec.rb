require 'rails_helper'

describe 'As a User' do
	describe 'when I visit the shelters pets page' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: 80003)
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", description: "Black Shepard", approximate_age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", description: "German Shepard", approximate_age: 4, sex: "Male")
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: 80221)
			@twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", description: "Doxine Mini", approximate_age: 7, sex: "Male")
		end

		it 'I see a list of all the pets in this shelter only' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.approximate_age)
			expect(page).to have_content(@jona.sex)

			expect(page).to have_css("img[src*='#{@ozzy.image}']")
			expect(page).to have_content(@ozzy.name)
			expect(page).to have_content(@ozzy.approximate_age)
			expect(page).to have_content(@ozzy.sex)
		end

		it 'I do not see any pets that do not belong in this shelter' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			expect(page).to have_css("img[src*='#{@jona.image}']")
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.description)
			expect(page).to have_content(@jona.approximate_age)
			expect(page).to have_content(@jona.sex)

			expect(page).to have_css("img[src*='#{@ozzy.image}']")
			expect(page).to have_content(@ozzy.name)
			expect(page).to have_content(@ozzy.approximate_age)
			expect(page).to have_content(@ozzy.sex)

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
	end
end
