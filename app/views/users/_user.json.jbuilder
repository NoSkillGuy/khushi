json.extract! user, :id, :first_name, :second_name, :email, :role, :created_at, :updated_at, :phone_number
json.url user_url(user, format: :json)
