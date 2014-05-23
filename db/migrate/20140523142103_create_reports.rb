class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
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

      t.timestamps
    end
    add_attachment :reports, :picture
  end
end
