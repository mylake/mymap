class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.string :attribute
      t.integer :map_id
      t.timestamps
    end
  end
end
