require 'test_helper'

class DinosaurTest < ActiveSupport::TestCase

  def test_fixtures_validity
    Dinosaur.all.each do |dino|
      assert dino.valid?, dino.errors.full_messages.to_s
    end
  end

  def test_creation
    assert_difference 'Dinosaur.count' do
      Dinosaur.create(
        :name   => 'Petrie',
        :colour => 'blue'
      )
    end
  end
  
  def test_validation
    dino = Dinosaur.new
    assert dino.invalid?
    assert_errors_on dino, [:name, :colour]
    
    dino.name = 'Petrie'
    dino.colour = 'brown'
    assert dino.invalid?
    assert_errors_on dino, :colour
  end
  
  def test_destroy
    assert_difference 'Dinosaur.count', -1 do
      dinosaurs(:default).destroy
    end
  end

end
