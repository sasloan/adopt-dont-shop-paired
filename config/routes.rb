Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	#root
	get '/', to: 'shelters#index'

	#shelters
	get '/shelters', to: 'shelters#index'
	get '/shelters/new', to: 'shelters#new'
	post '/shelters', to: 'shelters#create'
	get '/shelters/:shelter_id', to: 'shelters#show'
	get '/shelters/:shelter_id/edit', to: 'shelters#edit'
	patch '/shelters/:shelter_id', to: 'shelters#update'
	delete '/shelters/:shelter_id', to: 'shelters#destroy'
	get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'

	#pets
	get '/pets', to: 'pets#index'
	get '/pets/:pet_id', to: 'pets#show'
	get '/shelters/:shelter_id/pets/new', to: 'pets#new'
	post '/shelters/:shelter_id/pets', to: 'pets#create'
	get '/pets/:pet_id/edit', to: 'pets#edit'
	patch '/pets/:pet_id', to: 'pets#update'
	delete '/pets/:pet_id', to: 'pets#destroy'
	
	#shelter_reviews
	get '/shelters/:shelter_id/reviews/new', to: 'shelter_reviews#new'
	post '/shelters/:shelter_id/reviews', to: 'shelter_reviews#create'
	get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'shelter_reviews#edit'
	patch '/shelters/:shelter_id/reviews/:review_id', to: 'shelter_reviews#update'
	delete '/shelters/:shelter_id/reviews/:review_id', to: 'shelter_reviews#destroy'

	#favorites
	get '/favorites', to: 'favorites#index'
	patch '/favorites/:pet_id', to: 'favorites#update'
	delete '/favorites/:pet_id', to: 'favorites#destroy'
	delete '/favorites/', to: 'favorites#destroy_all'

	#applications
	get '/favorites/applications/new', to: 'applications#new'
	post '/favorites/applications/:application_id', to: 'applications#create'
end
