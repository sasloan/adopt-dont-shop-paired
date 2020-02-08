class ShelterReviewsController < ApplicationController

	def new
    @shelter = Shelter.find(params[:shelter_id])
	end
  
  def create
    @shelter = Shelter.find(params[:shelter_id])
		review = @shelter.reviews.create(review_params)
		
		if review.save
			redirect_to "/shelters/#{review.shelter.id}"
		else
			flash.now[:notice] = "Review not saved: Must fill in title, rating and content."
      render :new
		end
  end
	
	def edit
		@review = Review.find(params[:review_id])
	end
	
	def update
		@shelter = Shelter.find(params[:shelter_id])
		review = Review.find(params[:review_id])
		review.update(review_params)

		if review.save
			redirect_to "/shelters/#{@shelter.id}"
		else
			flash[:notice] = "Update review not saved: Must fill in title, rating and content."
			redirect_to "/shelters/#{@shelter.id}/reviews/#{review.id}/edit"
		end
	end
	
	def destroy
		shelter = Shelter.find(params[:shelter_id])
		review = Review.find(params[:review_id])
		review.delete

		redirect_to "/shelters/#{shelter.id}"
	end
  
  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
