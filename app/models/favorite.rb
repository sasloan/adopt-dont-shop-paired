class Favorite
  attr_reader :contents

	def initialize(initial_contents)
		@contents = initial_contents || Hash.new(0)
	end

	def ids
		@contents.keys.map do |key|
			key.to_i
		end
	end

  def total_count
    @contents.keys.length
  end

  def fav_pets
    ids.map do |id|
      Pet.find(id)
    end
  end

	def favorited?(pet_id)
		@contents.has_key?(pet_id.to_s)
	end

	def add_pet(pet_id)
  	@contents[pet_id.to_s] = true
	end

	def delete(pet_id)
	  @contents.except!(*pet_id)
	end

	def delete_all
		@contents = Hash.new
	end
end
