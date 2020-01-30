class PetsController < ApplicationController

	def index
		@pets = Pet.all
	end

	def show
		@pet = Pet.find(params[:pet_id])
	end

	def new
		@shelter = Shelter.find(params[:shelter_id])
	end

	def create
		@shelter = Shelter.find(params[:shelter_id])
		@pet = @shelter.pets.create(pet_params)

		redirect_to "/shelters/#{@shelter.id}/pets"
	end

	private

	def pet_params
		params.permit(:name, :approximate_age, :sex)
	end
end
