class SheltersController < ApplicationController

	def index
		@shelters = Shelter.all
	end

	def show
		@shelter = Shelter.find(params[:shelter_id])
	end

	def new
	end

	def create
		@shelter = Shelter.create(shelter_params)
		redirect_to "/shelters"
	end

	def edit
		@shelter = Shelter.find(params[:shelter_id])
	end

	def update
		@shelter = Shelter.find(params[:shelter_id])
		@shelter.update(shelter_params)

		redirect_to "/shelters/#{@shelter.id}"
	end

	def destroy
		@shelter = Shelter.find(params[:shelter_id])
		@shelter.delete

		redirect_to "/shelters"
	end

	def pets_index
		@shelter = Shelter.find(params[:shelter_id])
		@pets = @shelter.pets.all
	end


		def pets_new
			@shelter = Shelter.find(params[:shelter_id])
		end

		def pets_create
			@shelter = Shelter.find(params[:shelter_id])
			@pet = @shelter.pets.create(pet_params)

			redirect_to "/shelters/#{@shelter.id}/pets"
		end

	private

	def shelter_params
		params.permit(:name, :address, :city, :state, :zip)
	end
end
