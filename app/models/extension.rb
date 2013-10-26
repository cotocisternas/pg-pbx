# == Schema Information
#
# Table name: extensions
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  name              :string(80)       default(""), not null
#  accountcode       :string(20)
#  amaflags          :string(7)
#  callgroup         :string(10)
#  callerid          :string(80)
#  canreinvite       :string(3)        default("no"), not null
#  context           :string(80)
#  defaultip         :string(15)
#  dtmfmode          :string(7)        default("rfc2833"), not null
#  fromuser          :string(80)
#  fromdomain        :string(80)
#  host              :string(31)       default("dynamic"), not null
#  insecure          :string(40)       default("invite"), not null
#  language          :string(2)
#  mailbox           :string(50)
#  md5secret         :string(80)
#  nat               :string(20)       default("auto_force_rport"), not null
#  permit            :string(95)
#  mask              :string(95)
#  pickupgroup       :string(10)
#  port              :string(5)        default("5060"), not null
#  qualify           :string(3)        default("yes"), not null
#  restrictcid       :string(1)
#  rtptimeout        :string(3)
#  rtpholdtimeout    :string(3)
#  secret            :string(80)       default(""), not null
#  type              :string(255)      default("friend"), not null
#  username          :string(80)       default(""), not null
#  disallow          :string(100)      default("all")
#  allow             :string(100)      default("all")
#  musiconhold       :string(100)
#  regseconds        :integer
#  ipaddr            :string(45)
#  regexten          :string(80)
#  cancallforward    :string(3)        default("yes")
#  lastms            :integer          default(0), not null
#  defaultuser       :string(80)       default(""), not null
#  fullcontact       :string(80)
#  regserver         :string(30)
#  useragent         :string(40)
#  callbackextension :string(40)
#  created_at        :datetime
#  updated_at        :datetime
#

class Extension < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  
  belongs_to :user

  before_save :validate
  after_save :reload_sip
  after_update :reload_sip
  before_destroy :clean_did

  validates_presence_of :name
  validates_presence_of :context
  validates_numericality_of :name
  validates_uniqueness_of :name

  def reload_sip
    %x(sudo /usr/sbin/asterisk -rx 'sip reload')
  end

  private
    def validate
      self.callerid = User.find(user_id).first_name+" "+User.find(user_id).last_name+" <"+self.name+">"
      self.defaultuser = self.name
      self.secret = SecureRandom.hex(8)
      self.company_id = User.find(user_id).company_id
      self.department_id = User.find(user_id).department_id
    end

    def clean_did
      
    end

end
