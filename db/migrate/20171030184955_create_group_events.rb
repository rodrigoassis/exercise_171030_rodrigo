class CreateGroupEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :group_events do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :duration
      t.string :location
      t.float :latitude
      t.float :longitude
      t.boolean :published
      t.boolean :deleted

      t.timestamps
    end
  end
end
