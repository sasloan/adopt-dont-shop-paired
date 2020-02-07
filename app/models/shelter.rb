class Shelter < ApplicationRecord
	validates_presence_of :name,
												:address,
												:city,
												:state,
												:zip
	has_many :pets
	has_many :reviews, dependent: :destroy

	def pets_pending?
		pets.where(adoptable: false).none?
	end
end
