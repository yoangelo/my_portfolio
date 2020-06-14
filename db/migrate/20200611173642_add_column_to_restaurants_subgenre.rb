class AddColumnToRestaurantsSubgenre < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :subgenre, :string
  end
end
