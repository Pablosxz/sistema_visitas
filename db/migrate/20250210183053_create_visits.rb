class CreateVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :visits do |t|
      t.references :visitor, null: false, foreign_key: true
      t.references :sector, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.datetime :visit_time
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
