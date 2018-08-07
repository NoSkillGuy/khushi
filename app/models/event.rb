class Event < ApplicationRecord
	belongs_to :whatspp_message
	enum category: {
		high_risk: 0,
		mother: 1,
		child: 2,
		referral: 3,
		delivery: 4,
		stable: 5,
		alert: 6,
		anemia: 7,
		malnutrition: 8,
		uncoded: 9
	}
	KEY_WORDS = {
		'high risk': 0,
		'mother': 1,
		'child': 2,
		'refer': 3,
		'treatment': 3,
		'delivery': 4,
		'normal': 5,
		'teek': 5,
		'alert': 6,
		'hb': 7,
		'iron': 7,
		'mauc': 8
	}
	MAUC_VALUE = 12.5

	def self.set_events_for_a_whatspp_message whatspp_message_id: nil
		whatspp_message = WhatsppMessage.find(whatspp_message_id)
		whatspp_message_data = whatspp_message.data.downcase
		p whatspp_message_data
		KEY_WORDS.each do |key_word,key_word_type|
			if whatspp_message_data.include? key_word.to_s
				if key_word == 'mauc'
					whatspp_message_in_digits = []
					whatspp_message_data.split('').each do |ch|
						if ch == '.'
							whatspp_message_in_digits.push ch
						else
							if ch[/\d+/].nil?
								whatspp_message_in_digits.push ' '
							else
								whatspp_message_in_digits.push ch[/\d+/]
							end
						end
					end
					if whatspp_message_in_digits.join.split(" ").map{|x| x.to_i < 12.5}.include? true
						Event.create(whatspp_message_id: whatspp_message.id, category: key_word_type)	
					end					
				else
					Event.create(whatspp_message_id: whatspp_message.id, category: key_word_type)
				end
			end
		end
		Event.create(whatspp_message_id: whatspp_message.id, category: 9) if whatspp_message.events.count.zero?
	end

end



