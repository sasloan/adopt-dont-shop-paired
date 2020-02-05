class Favorite
  attr_reader :contents

	def initialize(initial_contents)
		@contents = initial_contents || Hash.new(0)
	end

  def total_count
    @contents.values.sum
  end

	def add_pet(id)
  	@contents[id.to_s] = count_of(id) + 1
	end

	def count_of(id)
    @contents[id.to_s].to_i
  end

	def find_keys
		@contents.keys.map do |key|
			key.to_i
		end
	end

	def remove_pet(id)
		@contents.except!(*id)
	end

	def favorited?(id)
    @contents.has_key?(id.to_s)
  end
end
