class AddColumnToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :age, :string
    add_column :profiles, :liveplace, :string
    add_column :profiles, :children, :string
    add_column :profiles, :introduce, :text
  end
end
