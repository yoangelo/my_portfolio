class AddResIdToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :res_id, :string
  end
end
