require 'rails_helper'

describe Pet, type: :model do
	describe 'Validations' do
		it {should validate_presence_of :name}
		it {should validate_presence_of :description}
		it {should validate_presence_of :approximate_age}
		it {should validate_presence_of :sex}
	end

	describe 'Relationships' do
		it {should belong_to :shelter}
	end
end
