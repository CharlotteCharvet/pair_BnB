class AddDatesToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :start_date, :date
    add_column :listings, :end_date, :date
  end
end
