require 'rails_helper'

describe Favorite, type: :model do

	describe "Methods" do
		before :each do
			@favorite_hash = {'1' => true,
												'2' => true,
												'3' => true,
												'4' => true
											}
			
			@list_1 = Favorite.new(@favorite_hash)
		end

		it "ids" do
			expect(@list_1.ids).to eq([1, 2, 3, 4])
		end

    it "#total_count" do
      expect(@list_1.total_count).to eq(4)
    end

    it "#add_pet" do
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

	  it "#favorited?" do
			expect(@list_1.favorited?("1")).to eq(true)
      expect(@list_1.favorited?("5")).to eq(false)
	  end

		it '#delete' do
			@list_1.delete("1")
      expected_hash = {"2" => true, "3" => true, "4" => true}
		end

		it '#delete_all' do
      @list_1.delete_all
      expect(@list_1.total_count).to eq(0)
    end
	end
end
