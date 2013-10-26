class Location < ActiveRecord::Base

  def name_with_code
    "#{name} (#{code})"   
  end
end