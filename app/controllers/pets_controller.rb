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
		shelter = Shelter.find(params[:shelter_id])
		pet = shelter.pets.new(pet_params)
		
		if pet.image == nil || pet.image == ""
			pet.image = "https://www.galadarigroup.com/wp-content/themes/Galadari_brothers/images/thumbnail-default.jpg"
		end
		
		if pet.save
			redirect_to "/shelters/#{shelter.id}/pets"
		else
			flash[:notice] = "Pet not Created: Required information missing."
			redirect_to "/shelters/#{shelter.id}/pets/new"
		end
	end

	def edit
		@pet = Pet.find(params[:pet_id])
	end

	def update
		pet = Pet.find(params[:pet_id])
		pet.update(pet_params)

		redirect_to "/pets/#{pet.id}"
	end

	def destroy
		Pet.destroy(params[:pet_id])

		redirect_to "/pets"
	end

	private

	def pet_params
		params.permit(:image, :name, :description, :age, :sex)
	end
end
