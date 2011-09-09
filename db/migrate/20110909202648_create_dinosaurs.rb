class CreateDinosaurs < ActiveRecord::Migration
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.string :colour
      t.timestamps
    end
  end
end
