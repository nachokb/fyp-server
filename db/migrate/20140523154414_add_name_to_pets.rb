class AddNameToPets < ActiveRecord::Migration
  def change
    change_table :reports do |t|
      t.string :name
    end
    change_table :sightings do |t|
      t.string :name
    end
  end
end
