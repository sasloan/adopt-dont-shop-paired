class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :rating
      t.string :content
      t.string :image, default: "https://www.galadarigroup.com/wp-content/themes/Galadari_brothers/images/thumbnail-default.jpg"
    end
  end
end
