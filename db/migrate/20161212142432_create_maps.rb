class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.string  :name
      t.float   :upper_left
      t.float   :lower_right
      t.string  :attribute
      t.integer :user_id

      t.timestamps
    end
  end
end
