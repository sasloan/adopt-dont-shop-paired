require 'rails_helper'

describe 'As a User' do
	describe 'when I visit the shelters pets page' do
		before :each do
			@aps = Shelter.create!(name: "Arvada Pet Shelter", address: "9876 Lamar Blvd.", city: "Arvada", state: "Co.", zip: 80003)
			@jona = @aps.pets.create!(image: "https://www.allthingsdogs.com/wp-content/uploads/2018/08/How-to-Care-for-a-Black-German-Shepherd.jpg", name: "Jona Bark", approximate_age: 6, sex: "Female")
			@ozzy = @aps.pets.create!(image: "https://www.insidedogsworld.com/wp-content/uploads/2017/06/German-Shepherd-Standard-Coat-GSC-1000x575-1-1-1-1.jpg", name: "Ozzy Paws Born", approximate_age: 4, sex: "Male")
			@acph = Shelter.create!(name: "Adams County Pet Hospital", address: "7834 Pecos St.", city: "Thornton", state: "Co.", zip: 80221)
			@twitch = @acph.pets.create!(image: "https://i.pinimg.com/originals/6e/3c/c1/6e3cc15c678002f4ece659442ae9aefd.jpg", name: "Twitch", approximate_age: 7, sex: "Male")
		end

		it 'I see a list of all the pets in this shelter only' do

			visit "/shelters/#{@aps.id}/pets"

			expect(current_path).to eq("/shelters/#{@aps.id}/pets")

			# expect(page).to have_content(@jona.image)
			expect(page).to have_content(@jona.name)
			expect(page).to have_content(@jona.approximate_age)
			expect(page).to have_content(@jona.sex)

			# expect(page).to have_content(@ozzy.image)
			expect(page).to have_content(@ozzy.name)
			expect(page).to have_content(@ozzy.approximate_age)
			expect(page).to have_content(@ozzy.sex)
		end

		it 'I do not see any pets that do not belong in this shelter' do

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

			expect(page).not_to have_css("img[src*='#{@twitch.image}']")
			expect(page).not_to have_content(@twitch.name)
		end
	end
end
