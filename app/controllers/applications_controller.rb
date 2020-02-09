class ApplicationsController < ApplicationController
  def new
    @fav_pets = favorites.fav_pets
  end
  
  def create
    pets_applied_for = []
    
    if params[:check_box].nil? == false
      params[:check_box].each do |pet_id|
        @pet = Pet.find(pet_id.to_i)
        @pet.applications.create(application_params)
        pets_applied_for << @pet.name
        
        favorites.contents.delete(pet_id)
      end
    end
    
    if pets_applied_for.count > 0 && @pet.save
      redirect_to "/favorites"
      flash[:notice] = "Application accepted for #{pets_applied_for.to_sentence}."
    else
      flash[:notice] = "Pet not created: Must fill out entire form."
			redirect_to "/applications/new"
    end
  end
  
  private
  
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end