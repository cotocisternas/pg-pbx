class CreateDialplans < ActiveRecord::Migration
  def change
    create_table :dialplans do |t|

      t.timestamps
    end
  end
end
