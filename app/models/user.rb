class User < ApplicationRecord
	has_many :whatsapp_messages
	enum role: {
		'admin': 0,
		'worker': 1
	}
end
