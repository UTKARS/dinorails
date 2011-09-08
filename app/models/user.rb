class User < ActiveRecord::Base

  # -- Validations ----------------------------------------------------------
  validates_presence_of :name
  
end
