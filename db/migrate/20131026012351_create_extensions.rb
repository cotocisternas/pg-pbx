class CreateExtensions < ActiveRecord::Migration
  def change
    create_table :extensions do |t|
      t.references  :user
      t.string    :name,              :null => false, :limit => 80, :default => ''
      t.string    :accountcode,       :limit => 20
      t.string    :amaflags,          :limit => 7
      t.string    :callgroup,         :limit => 10
      t.string    :callerid,          :limit => 80
      t.string    :canreinvite,       :null => false, :limit => 3, :default => "no"
      t.string    :context,           :limit => 80
      t.string    :defaultip,         :limit => 15
      t.string    :dtmfmode,          :null => false, :limit => 7, :default => "rfc2833"
      t.string    :fromuser,          :limit => 80
      t.string    :fromdomain,        :limit => 80
      t.string    :host,              :null => false, :limit => 31, :default => "dynamic"
      t.string    :insecure,          :null => false, :limit => 40, :default => "invite"
      t.string    :language,          :limit => 2
      t.string    :mailbox,           :limit => 50
      t.string    :md5secret,         :limit => 80
      t.string    :nat,               :null => false, :limit => 20, :default => "auto_force_rport"
      t.string    :permit,            :limit => 95
      t.string    :mask,              :limit => 95
      t.string    :pickupgroup,       :limit => 10
      t.string    :port,              :null => false, :limit => 5, :default => "5060"
      t.string    :qualify,           :null => false, :limit => 3, :default => "yes"
      t.string    :restrictcid,       :limit => 1
      t.string    :rtptimeout,        :limit => 3
      t.string    :rtpholdtimeout,    :limit => 3
      t.string    :secret,            :null => false, :limit => 80, :default => ''
      t.string    :type,              :null => false, :default => "friend"
      t.string    :username,          :null => false, :limit => 80, :default => ''
      t.string    :disallow,          :limit => 100, :default => "all"
      t.string    :allow,             :limit => 100, :default => "all"
      t.string    :musiconhold,       :limit => 100
      t.integer   :regseconds,        :limit => 8
      t.string    :ipaddr,            :limit => 45
      t.string    :regexten,          :limit => 80
      t.string    :cancallforward,    :limit => 3, :default => "yes"
      t.integer   :lastms,            :null => false, :default => 0
      t.string    :defaultuser,       :null => false, :limit => 80, :default => ''
      t.string    :fullcontact,       :limit => 80
      t.string    :regserver,         :limit => 30
      t.string    :useragent,         :limit => 40
      t.string    :callbackextension, :limit => 40
      t.timestamps
    end
    add_index :extensions,  :name,        :unique => true
    add_index :extensions,  :defaultuser, :unique => true
  end
end
