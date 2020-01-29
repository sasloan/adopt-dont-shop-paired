Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	#shelters
	get '/shelters', to: 'shelters#index'
	get '/shelters/:shelter_id', to: 'shelters#show'
	get '/shelters/:shelter_id/new', to: 'shelters#new'
	post '/shelters', to: 'shelters#create'
	get '/shelters/:shelter_id/edit', to: 'shelters#edit'
	patch '/shelters/:shelter_id', to: 'shelters#update'
	delete '/shelters/:shelter_id', to: 'shelters#destroy'
	get '/shelters/:shelter_id/pets', to: 'shelters#pets_index'

	#pets
	get '/pets', to: 'pets#index'
	get '/pets/:pet_id', to: 'pets#show'
end
