class AddColumnToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
  end
end
