class CreateCdrs < ActiveRecord::Migration
  def change
    create_table :cdrs do |t|
      t.string    :network,       :null => false, :limit => 10
      t.datetime  :calldate,      :default => Time.now, :limit => 0
      t.string    :clid,          :null => false, :limit => 80, :default => ''
      t.string    :src,           :null => false, :limit => 80, :default => ''
      t.string    :dst,           :null => false, :limit => 80, :default => ''
      t.string    :dcontext,      :null => false, :limit => 80, :default => ''
      t.string    :channel,       :null => false, :limit => 80, :default => ''
      t.string    :dstchannel,    :null => false, :limit => 80, :default => ''
      t.string    :lastapp,       :null => false, :limit => 80, :default => ''
      t.string    :lastdata,      :null => false, :limit => 80, :default => ''
      t.integer   :duration,      :null => false, :limit => 8
      t.integer   :billsec,       :null => false, :limit => 8
      t.string    :disposition,   :null => false, :limit => 45, :default => ''
      t.string    :amaflags,      :null => false, :limit => 255
      t.string    :accountcode,   :null => false, :limit => 20, :default => ''
      t.string    :uniqueid,      :null => false, :limit => 32, :default => ''
      t.string    :userfield,     :null => false, :limit => 255, :default => ''
    end
    add_index :cdrs, :uniqueid, :unique => true
  end
end
