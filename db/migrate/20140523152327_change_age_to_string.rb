class ChangeAgeToString < ActiveRecord::Migration
  def change
    change_column :reports, :age, :string
    change_column :sightings, :age, :string
  end
end
