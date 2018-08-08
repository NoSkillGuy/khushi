json.extract! whatspp_message, :created_at
json.first_name whatspp_message.user.first_name
json.phone_number whatspp_message.user.phone_number
json.event_category whatspp_message.events.pluck(:category).join(',')
json.message whatspp_message.data