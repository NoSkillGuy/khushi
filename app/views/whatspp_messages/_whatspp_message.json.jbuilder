json.extract! whatspp_message, :id, :data, :user_id, :spam, :created_at, :updated_at
json.url whatspp_message_url(whatspp_message, format: :json)
