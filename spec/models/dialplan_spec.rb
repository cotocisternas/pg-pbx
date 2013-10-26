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

require 'spec_helper'

describe Dialplan do
  pending "add some examples to (or delete) #{__FILE__}"
end
