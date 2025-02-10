class CreateUnits < ActiveRecord::Migration[8.0]
  def change
    create_table :units do |t|
      t.string :name

      t.timestamps
    end
  end
end
