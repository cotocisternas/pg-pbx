class Did < ActiveRecord::Base

  before_update :prepare_args, :prepare_app
  before_create :prepare_app
  after_save    :create_dialplan
  before_destroy :clean_dialplan

  validates_presence_of :did
  validates_numericality_of :did
  validates_uniqueness_of :did
  validates_length_of :did, :is => 8

  def prepare_app
    if self.app.nil? || self.app.empty?
      self.app = "Hangup"
    end
  end

  def prepare_args
    if app == "Dial"
      extension = Extension.find(app_arg)
      extension = extension.name
      self.app_arg = "SIP/#{extension},60"
    elsif app == "Hangup"
      self.app_arg = nil
    end
  end

  def create_dialplan
    Dialplan.did_dialplan(self.did,self.app,self.app_arg)
  end

  def clean_dialplan
    Dialplan.del_did(self.did)
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |did|
        csv << did.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Did.create! row.to_hash
    end
  end

end