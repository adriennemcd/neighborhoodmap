class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps null: false
    end
  end
end
