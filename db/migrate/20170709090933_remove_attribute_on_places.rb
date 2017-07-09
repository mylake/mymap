class RemoveAttributeOnPlaces < ActiveRecord::Migration[5.0]
  def change
    remove_column :places, :attribute
  end
end
