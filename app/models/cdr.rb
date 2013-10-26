# == Schema Information
#
# Table name: cdrs
#
#  id          :integer          not null, primary key
#  network     :string(10)       not null
#  calldate    :datetime         default(2013-10-26 01:48:20 UTC)
#  clid        :string(80)       default(""), not null
#  src         :string(80)       default(""), not null
#  dst         :string(80)       default(""), not null
#  dcontext    :string(80)       default(""), not null
#  channel     :string(80)       default(""), not null
#  dstchannel  :string(80)       default(""), not null
#  lastapp     :string(80)       default(""), not null
#  lastdata    :string(80)       default(""), not null
#  duration    :integer          not null
#  billsec     :integer          not null
#  disposition :string(45)       default(""), not null
#  amaflags    :string(255)      not null
#  accountcode :string(20)       default(""), not null
#  uniqueid    :string(32)       default(""), not null
#  userfield   :string(255)      default(""), not null
#

class Cdr < ActiveRecord::Base
end
