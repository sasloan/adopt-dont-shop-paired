class Shelter < ApplicationRecord
	validates_presence_of :name,
												:address,
												:city,
												:state,
												:zip
	has_many :pets, dependent: :destroy
	has_many :reviews, dependent: :destroy

	def pets_pending?
		pets.where(adoptable: false).none?
	end

	def application_count
		pets.joins(:applications)
			.select(:application_id)
			.distinct.count
	end
end
