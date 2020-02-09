class Review < ApplicationRecord
  validates_presence_of :title,
                        :rating,
                        :content
  belongs_to :shelter

	def self.average_rating
		self.average(:rating) || 0
	end
end
