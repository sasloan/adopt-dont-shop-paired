class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :image, default: "https://www.galadarigroup.com/wp-content/themes/Galadari_brothers/images/thumbnail-default.jpg"
      t.string :name
      t.integer :age
      t.string :sex
    end
  end
end
