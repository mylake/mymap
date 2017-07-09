class AddCategoryUserIdToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :category, :string
    add_column :places, :user_id, :integer
    add_column :places, :desc, :text
  end
end
