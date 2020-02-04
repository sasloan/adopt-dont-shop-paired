class FavoritesController < ApplicationController
	include ActionView::Helpers::TextHelper
	
	def update
		pet = Pet.find(params[:pet_id])
		pet_id_str = pet.id.to_s
		session[:favorites] ||= Hash.new(0)
		session[:favorites][pet_id_str] ||= 0
		session[:favorites][pet_id_str] = session[:favorites][pet_id_str] + 1
		quantity = session[:favorites][pet_id_str]
		flash[:notice] = "#{pet.name} has been added to your favorites"
		redirect_to "/pets/#{pet.id}"
	end
end
