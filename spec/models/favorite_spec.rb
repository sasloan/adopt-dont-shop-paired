require 'rails_helper'

describe Favorite, type: :model do
  describe "#total_count" do
    it "can calculate the total number of favorites it holds" do
      favorite = Favorit.new({
        1 => 2,  # two copies of song 1
        2 => 3   # three copies of song 2
      })
      expect(favorite.total_count).to eq(5)
    end
  end
end
