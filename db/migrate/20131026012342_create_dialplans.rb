class CreateDialplans < ActiveRecord::Migration
  def change
    create_table :dialplans do |t|
      t.string    :context,             :null => false, :limit => 20, :default => ''
      t.string    :exten,               :null => false, :limit => 20, :default => ''
      t.integer   :priority,            :null => false, :limit => 2, :default => 0
      t.string    :app,                 :null => false, :limit => 20, :default => ''
      t.string    :appdata,             :limit => 128
      t.string    :network,             :null => false, :limit => 128
    end
  end
end
