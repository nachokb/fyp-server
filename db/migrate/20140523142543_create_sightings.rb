class CreateSightings < ActiveRecord::Migration
  def change
    create_table :sightings do |t|
      t.float :lat
      t.float :long
      t.string :email
      t.string :description
      t.string :species
      t.string :race
      t.string :size
      t.string :color
      t.integer :age
      t.string :sex

      t.belongs_to :report

      t.timestamps
    end
    add_attachment :sightings, :picture
  end
end
