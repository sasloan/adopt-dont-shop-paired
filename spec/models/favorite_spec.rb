require 'rails_helper'

describe Favorite, type: :model do
	before :each do
		@favorite_hash = {'1' => true,
											'2' => true,
											'3' => true,
											'4' => true
										}

		@list_1 = Favorite.new(@favorite_hash)
	end

	describe "#ids" do
		it "I can see all the ids as keys in the favorites contents." do
			expect(@list_1.ids).to eq([1, 2, 3, 4])
		end
	end

  describe "#total_count" do
    it "I can calculate the total number of favorites it holds" do
      expect(@list_1.total_count).to eq(4)
    end
  end

	describe "#add_pet" do
    it "I add a pet to its contents" do

      @list_1.add_pet('5')
      @list_1.add_pet('6')

			expected_hash = {'1' => true,
											 '2' => true,
										 	 '3' => true,
										 	 '4' => true,
										 	 '5' => true,
										 	 '6' => true
										 	 }

      expect(@list_1.contents).to eq(expected_hash)
    end
	end

	describe "#favorited?" do
	  it "I can tell if this id has been favorited" do
			expect(@list_1.favorited?("1")).to eq(true)
      expect(@list_1.favorited?("5")).to eq(false)
	  end
	end

	describe "#delete" do
		it 'I can delete a pet from the favorites index' do
			@list_1.delete("1")
      expected_hash = {"2" => true, "3" => true, "4" => true}
		end
	end

	describe "#delete_all" do
		it 'I can delete all pets from its favorites list' do
      @list_1.delete_all
      expect(@list_1.total_count).to eq(0)
    end
	end
end
