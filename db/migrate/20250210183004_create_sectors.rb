class CreateSectors < ActiveRecord::Migration[8.0]
  def change
    create_table :sectors do |t|
      t.string :name
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
