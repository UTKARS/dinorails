class User < ActiveRecord::Base

  PREFIX = 'Dinosaur Owner'

  # -- Validations ----------------------------------------------------------
  validates_presence_of :name

  # -- Class Methods --------------------------------------------------------
  def self.fancy_name(name)
    PREFIX + " #{name}"
  end
  
  # -- Instance Methods -----------------------------------------------------
  def fancy_name
    self.class.fancy_name(self.name)
  end
  
end
