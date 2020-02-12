class Pet < ApplicationRecord
	validates_presence_of :name,
												:description,
												:age,
												:sex

	has_many :pet_applications, dependent: :destroy
	has_many :applications, through: :pet_applications
	belongs_to :shelter

	def self.pet_count
		count
	end

	def approved_application_name
		pet_application = PetApplication.where(pet_id: self.id, approved: true).first
		Application.find(pet_application.application_id).name
	end

	def approved?
		approved_applications = PetApplication.select(:approved).where(pet_id: self.id, approved: true)
		return true if approved_applications.count > 0
		false
	end
end
