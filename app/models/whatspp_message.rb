class WhatsppMessage < ApplicationRecord
	belongs_to :user
	has_many :events

	def set_events
		Event.set_events_for_a_whatspp_message whatspp_message_id: self.id
	end
end
