class CreateCampuses < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'

    create_table :campuses, id: :uuid do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :url, limit: 1024
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.timestamps
    end
  end
end
