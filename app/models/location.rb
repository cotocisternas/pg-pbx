# == Schema Information
#
# Table name: locations
#
#  id      :integer          not null, primary key
#  region  :integer
#  name    :string(255)
#  capital :string(255)
#  code    :string(255)
#

class Location < ActiveRecord::Base

  def name_with_code
    "#{name} (#{code})"   
  end
end
