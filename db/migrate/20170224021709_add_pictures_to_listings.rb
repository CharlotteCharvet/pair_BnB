class AddPicturesToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :picturse, :json
  end
end
