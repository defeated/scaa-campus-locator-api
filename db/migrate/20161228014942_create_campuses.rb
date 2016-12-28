class CreateCampuses < ActiveRecord::Migration[5.0]
  def change
    create_table :campuses do |t|
      t.string :name, nullable: false
      t.string :address, nullable: false
      t.string :url, limit: 1024
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.timestamps
    end
  end
end
