class MakeUserIdNullableInEmployees < ActiveRecord::Migration[8.0]
  def change
    change_column_null :employees, :user_id, true  # Permite valores nulos para user_id
  end
end
