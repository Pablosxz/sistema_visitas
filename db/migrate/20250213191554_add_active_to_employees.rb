class AddActiveToEmployees < ActiveRecord::Migration[8.0]
  def change
    add_column :employees, :active, :boolean, default: true
    add_column :units, :active, :boolean, default: true
    add_column :sectors, :active, :boolean, default: true
  end
end
