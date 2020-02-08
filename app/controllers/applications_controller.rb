class ApplicationsController < ApplicationController
  def new
    @fav_pets = favorites.fav_pets
  end
  
  def create
    pets_applied_for = []
    
    params[:check_box].each do |pet_id|
      pet = Pet.find(pet_id.to_i)
      pet.applications.create(application_params)
      pets_applied_for << pet.name
      
      favorites.contents.delete(pet_id)
    end
    
		redirect_to "/favorites"
    flash[:notice] = "Application accepted for #{pets_applied_for.to_sentence}."
  end
  
  private
  
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end