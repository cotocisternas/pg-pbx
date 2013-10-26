# == Schema Information
#
# Table name: dids
#
#  id      :integer          not null, primary key
#  did     :string(10)       not null
#  app     :string(20)       not null
#  app_arg :string(80)
#

require 'spec_helper'

describe Did do
  pending "add some examples to (or delete) #{__FILE__}"
end
