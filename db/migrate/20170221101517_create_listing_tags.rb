class CreateListingTags < ActiveRecord::Migration[5.0]
  def change
    create_table :listing_tags do |t|
    	t.references :tag, foreign_key: true, index: true
    	t.references :listing, foreign_key: true, index: true

      t.timestamps null:false
    end
  end
end
