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
		shelter = Shelter.new(shelter_params)
		if shelter.save
			redirect_to "/shelters"
		else 
			flash[:notice] = "Shelter not Created: Required information missing."
			render :new
		end
	end

	def edit
		@shelter = Shelter.find(params[:shelter_id])
	end

	def update
		shelter = Shelter.find(params[:shelter_id])
		shelter.update(shelter_params)

		redirect_to "/shelters/#{shelter.id}"
	end

	def destroy
		shelter = Shelter.find(params[:shelter_id])
		shelter.delete

		redirect_to "/shelters"
	end

	private

	def shelter_params
		params.permit(:name, :address, :city, :state, :zip)
	end
end
