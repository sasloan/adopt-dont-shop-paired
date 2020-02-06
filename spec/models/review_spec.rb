require 'rails_helper'

describe Review, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :title}
		it {should validate_presence_of :rating}
		it {should validate_presence_of :content}
  end
  
  describe 'Relationships' do
    it {should belong_to :shelter}
  end
end