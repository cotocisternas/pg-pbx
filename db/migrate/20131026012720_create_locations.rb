class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :region
      t.string :name
      t.string :capital
      t.string :code
    end
  end
end
