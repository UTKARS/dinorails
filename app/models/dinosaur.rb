class Dinosaur < ActiveRecord::Base
  
  # -- Constants ------------------------------------------------------------
  COLOURS = %w(red blue green magenta)
  
  # -- Validations ----------------------------------------------------------
  validates_presence_of :name
  validates :colour, :inclusion => COLOURS
  
end
