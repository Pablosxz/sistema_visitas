class AddActiveToVisitors < ActiveRecord::Migration[8.0]
  def change
    add_column :visitors, :active, :boolean, default: true
  end
end
