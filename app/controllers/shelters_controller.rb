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
			flash[:incomplete] = "You attempted to submit the form without completing required field(s): #{empty_params(shelter_params)}"
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
		Shelter.destroy(params[:shelter_id])

		redirect_to "/shelters"
	end

	private

	def shelter_params
		params.permit(:name, :address, :city, :state, :zip)
	end
end
