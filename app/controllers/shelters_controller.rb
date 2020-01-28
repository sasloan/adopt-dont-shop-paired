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
	end

	private

	def shelter_params
		params.permit(:name, :address, :city, :state, :zip)
	end
end
