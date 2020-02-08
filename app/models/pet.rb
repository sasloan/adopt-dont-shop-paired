class Pet < ApplicationRecord
	validates_presence_of :name,
												:description,
												:age,
												:sex
	has_many :pet_applications
	has_many :applications, through: :pet_applications
	belongs_to :shelter

	def self.pet_count
		count
	end
end
