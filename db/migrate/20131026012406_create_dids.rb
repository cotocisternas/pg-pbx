class CreateDids < ActiveRecord::Migration
  def change
    create_table :dids do |t|

      t.timestamps
    end
  end
end
