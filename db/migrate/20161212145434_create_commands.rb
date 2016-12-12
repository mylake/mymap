class CreateCommands < ActiveRecord::Migration[5.0]
  def change
    create_table :commands do |t|
      t.text :content
      t.integer :map_id
      t.integer :place_id
      t.timestamps
    end
  end
end
