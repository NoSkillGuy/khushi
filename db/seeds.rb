# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
u = User.new(first_name: 'Khushi', second_name: 'Admin', email: 'admin@khushi.com', role: 0, phone_number: '+918008270250')
u.password = 'password'
u.password_confirmation = 'password'
u.skip_confirmation!
u.save
20.times do |i|
	fn,sn = Faker::FunnyName.two_word_name.split(' ')
	u = User.create(first_name: fn, second_name: sn, email: Faker::Internet.email, phone_number: Faker::PhoneNumber.phone_number)
	u.password = 'password'
	u.password_confirmation = 'password'
	u.skip_confirmation!
	u.save
end

data_templates = [
	'high risk',
	'mother',
	'child',
	'refer',
	'treatment',
	'delivery',
	'normal',
	'teek',
	'alert',
	'HB',
	'iron',
	"MAUC #{Faker::Number.between(1, 20)}"
]

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

def set_events_for_a_whatspp_message whatspp_message_id: nil
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
					Event.create(whatspp_message_id: whatspp_message.id, category: key_word_type, created_at: whatspp_message.created_at, updated_at: whatspp_message.created_at)	
				end					
			else
				Event.create(whatspp_message_id: whatspp_message.id, category: key_word_type, created_at: whatspp_message.created_at, updated_at: whatspp_message.created_at)
			end
		end
	end
	Event.create(whatspp_message_id: whatspp_message.id, category: 9, created_at: whatspp_message.created_at, updated_at: whatspp_message.created_at) if whatspp_message.events.count.zero?
end



20.times do |t|
	tm = Time.now - t*60
	10.times do |i|
		wm = WhatsppMessage.create(data: "#{Faker::HarryPotter.quote} #{data_templates.sample} #{data_templates.sample} #{data_templates.sample}", created_at: tm, updated_at: tm, user_id: Faker::Number.between(2, 21))
		set_events_for_a_whatspp_message whatspp_message_id: wm.id
	end
end

