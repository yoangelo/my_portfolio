class AddColumnToRestaurantsOpentime < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :opentime, :string
  end
end
