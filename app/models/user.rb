class User < ApplicationRecord
	has_many :whatspp_messages
	enum role: {
		'admin': 0,
		'worker': 1
	}
end
