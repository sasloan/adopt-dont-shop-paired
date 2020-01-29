class Pet < ApplicationRecord
	validates_presence_of :name,
												:approximate_age,
												:sex
	belongs_to :shelter
end
