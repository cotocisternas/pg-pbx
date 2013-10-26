# == Schema Information
#
# Table name: dialplans
#
#  id       :integer          not null, primary key
#  context  :string(20)       default(""), not null
#  exten    :string(20)       default(""), not null
#  priority :integer          default(0), not null
#  app      :string(20)       default(""), not null
#  appdata  :string(128)
#  network  :string(128)      not null
#

class Dialplan < ActiveRecord::Base

  validates_presence_of :context
  validates_presence_of :exten
  validates_presence_of :priority
  validates_presence_of :app
  validates_presence_of :network

  validates_numericality_of :priority

  default_scope :conditions => ['context NOT SIMILAR TO ?', '%DID']
  scope :did,   :conditions => ['context LIKE ?', '%DID']

  def self.reload_dialplan
    %x(sudo /usr/sbin/asterisk -rx 'dialplan reload')
  end

  def self.did_dialplan(did,app,arg)
    del_did(did)
    Dialplan.create(context: "DID",exten: "_#{did}",priority: 1,app: "Set",appdata: "CDR(network)=DID",network: "DID")
    Dialplan.create(context: "DID",exten: "_#{did}",priority: 2,app: "#{app}",appdata: "#{arg}",network: "DID")
    Dialplan.create(context: "DID",exten: "_02#{did}",priority: 1,app: "Set",appdata: "CDR(network)=DID",network: "DID")
    Dialplan.create(context: "DID",exten: "_02#{did}",priority: 2,app: "#{app}",appdata: "#{arg}",network: "DID")
    Dialplan.reload_dialplan
  end

  def self.ext_dialplan
    Dialplan.create(context: "EXT",exten: "_ZXXX",priority: 1,app: "Set",appdata: "CDR(network)=EXT",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_ZXXX",priority: 2,app: "Dial",appdata: "SIP/${EXTEN},60",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_ZXXX",priority: 3,app: "Hangup",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_131",priority: 1,app: "Set",appdata: "CDR(network)=AMBULANCIA",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_131",priority: 2,app: "Dial",appdata: "SIP/131@TRUNK,60",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_131",priority: 3,app: "Hangup",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_132",priority: 1,app: "Set",appdata: "CDR(network)=BOMBEROS",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_132",priority: 2,app: "Dial",appdata: "SIP/132@TRUNK,60",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_132",priority: 3,app: "Hangup",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_133",priority: 1,app: "Set",appdata: "CDR(network)=POLICIA",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_133",priority: 2,app: "Dial",appdata: "SIP/133@TRUNK,60",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_133",priority: 3,app: "Hangup",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_103",priority: 1,app: "Set",appdata: "CDR(network)=SRV-TEC",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_103",priority: 2,app: "Dial",appdata: "SIP/103@TRUNK,60",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_103",priority: 3,app: "Hangup",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_107",priority: 1,app: "Set",appdata: "CDR(network)=CONSULTAS",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_107",priority: 2,app: "Dial",appdata: "SIP/107@TRUNK,60",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_107",priority: 3,app: "Hangup",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_800XXXXXX",priority: 1,app: "Set",appdata: "CDR(network)=Linea800",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_800XXXXXX",priority: 2,app: "Dial",appdata: "SIP/${EXTEN}@TRUNK,60",network: "EXT")
    Dialplan.create(context: "EXT",exten: "_800XXXXXX",priority: 3,app: "Hangup",network: "EXT")
  end

  def self.slm_dialplan
    Dialplan.create(context: "SLM",exten: "_2NXXXXXX",priority: 1,app: "Set",appdata: "CDR(network)=SLM",network: "SLM")
    Dialplan.create(context: "SLM",exten: "_2NXXXXXX",priority: 2,app: "Dial",appdata: "SIP/${EXTEN}@TRUNK,60",network: "SLM")
    Dialplan.create(context: "SLM",exten: "_2NXXXXXX",priority: 3,app: "Hangup",network: "SLM")
    Dialplan.create(context: "SLM",exten: "_600XXXXXXX",priority: 1,app: "Set",appdata: "CDR(network)=Linea600",network: "SLM")
    Dialplan.create(context: "SLM",exten: "_600XXXXXXX",priority: 2,app: "Dial",appdata: "SIP/${EXTEN}@TRUNK,60",network: "SLM")
    Dialplan.create(context: "SLM",exten: "_600XXXXXXX",priority: 3,app: "Hangup",network: "SLM")
  end

  def self.ldn_dialplan
    loc = []
    @locations = Location.all
    @locations.each do |location|
      loc << location.code
    end
    loc.uniq!
    loc.each do |l|
      Dialplan.create(context: "LDN",exten: "_#{l}.",priority: 1,app: "Set",appdata: "CDR(network)=LDN",network: "LDN")
      if l == "02"
        Dialplan.create(context: "LDN",exten: "_#{l}.",priority: 2,app: "Dial",appdata: "SIP/${EXTEN:2}@TRUNK,60",network: "LDN")
      else
        Dialplan.create(context: "LDN",exten: "_#{l}.",priority: 2,app: "Dial",appdata: "SIP/${EXTEN}@TRUNK,60",network: "LDN")
      end
      Dialplan.create(context: "LDN",exten: "_#{l}.",priority: 3,app: "Hangup",network: "LDN")
    end
  end

  def self.movil_dialplan
    Dialplan.create(context: "MOVIL",exten: "_09.",priority: 1,app: "Set",appdata: "CDR(network)=MOVIL",network: "MOVIL")
    Dialplan.create(context: "MOVIL",exten: "_09.",priority: 2,app: "Dial",appdata: "SIP/${EXTEN}@TRUNK,60",network: "MOVIL")
    Dialplan.create(context: "MOVIL",exten: "_09.",priority: 3,app: "Hangup",network: "MOVIL")
    Dialplan.create(context: "MOVIL",exten: "_9XXXXXXXX!",priority: 1,app: "Set",appdata: "CDR(network)=MOVIL",network: "MOVIL")
    Dialplan.create(context: "MOVIL",exten: "_9XXXXXXXX!",priority: 2,app: "Dial",appdata: "SIP/${EXTEN}@TRUNK,60",network: "MOVIL")
    Dialplan.create(context: "MOVIL",exten: "_9XXXXXXXX!",priority: 3,app: "Hangup",network: "MOVIL")
  end

  def self.ldi_dialplan
    Dialplan.create(context: "LDI",exten: "_00.",priority: 1,app: "Set",appdata: "CDR(network)=LDI",network: "LDI")
    Dialplan.create(context: "LDI",exten: "_00.",priority: 2,app: "Dial",appdata: "SIP/${EXTEN}@TRUNK,60",network: "LDI")
    Dialplan.create(context: "LDI",exten: "_00.",priority: 3,app: "Hangup",network: "LDI")
  end

  def self.rebuild_dialplan
    dialplans = Dialplan.all
    dialplans.each do |d|
      d.destroy
    end

    File.open("/etc/asterisk/extensions.conf", "w") { |data| 
      data << ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n"
      data << ";;;;;;;;;;;;NO TOCAR;;;;;;;;;;;;;;\n"
      data << ";FICHERO GENERADO AUTOMATICAMENTE;\n"
      data << ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n"
      data << "\n"
      data << "[general]\n"
      data << "static=yes\n"
      data << "writeprotect=no\n"
      data << "autofallthrough=yes\n"
      data << "clearglobalvars=no\n"
      data << "priorityjumping=no\n"
      data << "#include /etc/asterisk/extensions_did.conf\n"
      data << "\n"
      data << "[globals]\n"
      data << "\n"
      data << "\n"
      data << "[EXT]\n"
      data << "switch => Realtime/@\n"
      data << "\n"
      data << "[SLM]\n"
      data << "include => EXT\n"
      data << "switch => Realtime/@\n"
      data << "\n"
      data << "[LDN]\n"
      data << "include => EXT\n"
      data << "include => SLM\n"
      data << "switch => Realtime/@\n"
      data << "\n"
      data << "[MOVIL]\n"
      data << "include => EXT\n"
      data << "include => SLM\n"
      data << "include => LDN\n"
      data << "switch => Realtime/@\n"
      data << "\n"
      data << "[LDI]\n"
      data << "include => EXT\n"
      data << "include => SLM\n"
      data << "include => LDN\n"
      data << "include => MOVIL\n"
      data << "switch => Realtime/@\n"
    }

    File.open("/etc/asterisk/extensions_did.conf", "w") { |data| 
      data << ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n"
      data << ";;;;;;;;;;;;NO TOCAR;;;;;;;;;;;;;;\n"
      data << ";FICHERO GENERADO AUTOMATICAMENTE;\n"
      data << ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n"
      data << "\n"
      data << "[DID]\n"
      data << "switch => Realtime/@\n"
    }

    ext_dialplan
    slm_dialplan
    ldn_dialplan
    movil_dialplan
    ldi_dialplan
    Dialplan.reload_dialplan
  end

  def self.del_did(did)
    d = Dialplan.unscoped.did.find_all_by_exten("_#{did}")
    unless d.nil?
      d.each do |did|
        did.destroy
      end
    end
    d = Dialplan.unscoped.did.find_all_by_exten("_02#{did}")
    unless d.nil?
      d.each do |did|
        did.destroy
      end
    end
  end
end