class AddColumnRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :image_url_1, :text
    add_column :restaurants, :image_url_2, :text
  end
end
