class User < ApplicationRecord
	enum role: {
		'admin': 0,
		'worker': 1
	}
end
