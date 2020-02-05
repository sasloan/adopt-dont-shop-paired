class FavoritesController < ApplicationController
	include ActionView::Helpers::TextHelper

	def index
		@pets = Pet.all
	end


	def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    quantity = favorites.count_of(pet.id)
		flash[:notice] = "#{pet.name} has been added to your favorites"
    redirect_to "/pets/#{pet.id}"
  end


	def destroy
		pet = Pet.find(params[:pet_id])
		favorites.remove_pet(params[:id])
	  session[:favorites] = favorites.favorited?(params[:id])
	  flash[:notice] = "#{pet.name} has been removed from your favorites"
	  redirect_back(fallback_location: '/favorites')
	end
end
