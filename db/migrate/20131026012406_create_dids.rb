class CreateDids < ActiveRecord::Migration
  def change
    create_table :dids do |t|
      t.string    :did,           :null => false, :limit => 10
      t.string    :app,           :null => false, :limit => 20
      t.string    :app_arg,       :limit => 80
    end
  end
end