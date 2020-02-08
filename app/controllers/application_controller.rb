class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	helper_method :favorites

	def favorites
		@favorites ||= Favorite.new(session[:favorites])
	end

	def empty_params(strong_params)
	 strong_params.to_h.reduce("") do |empty_params,(key, value)|
		 next empty_params if value != ""
		 empty_params.empty? ? empty_params += key.capitalize : empty_params += ', ' + key.capitalize
	 end
 	end
end
