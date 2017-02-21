class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
    	t.references :user, foreign_key: true, index: true
    	t.string :title
    	t.text :description
    	t.string :city
    	t.string :address
    	t.integer :price
    	t.integer :max_guests

      t.timestamps null: false
    end
  end
end
