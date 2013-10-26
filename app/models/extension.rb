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