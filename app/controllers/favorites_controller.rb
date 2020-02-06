class FavoritesController < ApplicationController
	include ActionView::Helpers::TextHelper

	def index
		@pets = Pet.all
	end

	def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(params[:pet_id])
    session[:favorites] = favorites.contents
		flash[:notice] = "#{pet.name} has been added to your favorites"
    redirect_to "/pets/#{pet.id}"
  end

	def destroy
		pet = Pet.find(params[:pet_id])
		favorites.delete(params[:pet_id])
		session[:favorites] = favorites.contents
		flash[:notice] = "#{pet.name} has been removed from your favorites"
		redirect_back(fallback_location: '/favorites')
	end

	def destroy_all
		favorites.delete_all
	  session[:favorites] = favorites.contents
		flash[:notice] = "All pets have been removed from your favorites."
		redirect_to "/favorites"
	end
end
