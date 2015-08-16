class AddYearAndNeighborhoodToUsers < ActiveRecord::Migration
  def change
    add_column :users, :year, :integer
    add_column :users, :neighborhood, :string
  end
end
