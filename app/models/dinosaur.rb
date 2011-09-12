class Dinosaur < ActiveRecord::Base
  
  # -- Constants ------------------------------------------------------------
  COLOURS = %w(red blue green magenta)
  
  # -- Validations ----------------------------------------------------------
  validates :name, :presence => true
  validates :colour, :inclusion => COLOURS
  
end
