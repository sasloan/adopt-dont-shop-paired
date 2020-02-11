class ApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
  end

  def new
    @fav_pets = favorites.fav_pets
  end

  def show
    @application = Application.find(params[:application_id])
  end

  def create
		application = Application.create(application_params)
    pets_applied_for = []

    if params[:check_box].nil? == false

      params[:check_box].each do |pet_id|
        pet = Pet.find(pet_id.to_i)
        pets_applied_for << pet.name

        @pet_application = PetApplication.create(pet_id: pet_id, application_id: application.id)
        favorites.contents.delete(pet_id)
      end
    end

    if pets_applied_for.count > 0 && @pet_application.save
      redirect_to "/favorites"
      flash[:notice] = "Application accepted for #{pets_applied_for.to_sentence}."
    else
			flash[:error] = application.errors.full_messages.to_sentence
# flash[:notice] = "Pet not created: Must fill out entire form."
			redirect_to "/applications/new"
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
