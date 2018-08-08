class User < ApplicationRecord
	has_many :whatspp_messages
	has_many :events, through: :whatspp_messages
	enum role: {
		'admin': 0,
		'worker': 1
	}
end
