class AmilcarLikesLon < ActiveRecord::Migration
  def change
    change_table :reports do |t|
      t.remove :long
      t.float :lon
    end
    change_table :sightings do |t|
      t.remove :long
      t.float :lon
    end
  end
end
