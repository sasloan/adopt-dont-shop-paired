class Pet < ApplicationRecord
	validates_presence_of :name,
												:description,
												:age,
												:sex
	belongs_to :shelter

	def self.pet_count
		count
	end
end
