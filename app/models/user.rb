class User < ActiveRecord::Base

  # -- Validations ----------------------------------------------------------
  validates_presence_of :name

  # -- Instance Methods -----------------------------------------------------
  def fancy_name
    "Dinosaur Owner #{self.name}"
  end
  
end
