json.extract! employee, :id, :name, :sector_id, :user_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
