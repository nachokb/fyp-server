class AddStatuses < ActiveRecord::Migration
  def change
    change_table :reports do |t|
      t.string :status
    end

    change_table :sightings do |t|
      t.string :status
    end
  end
end
