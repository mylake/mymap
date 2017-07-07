# frozen_string_literal: true

class CreateJwtAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :jwt_authentications do |t|
      t.string :name
      t.string :key
      t.string :secret

      t.timestamps
    end
  end
end
