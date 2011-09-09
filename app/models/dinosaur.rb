class Dinosaur < ActiveRecord::Base
  
  # -- Validations ----------------------------------------------------------
  validates_presence_of :name
  validates :colour, :inclusion => %w(red blue green magenta)
  
end
