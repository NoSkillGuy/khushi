# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
User.create(first_name: 'Siva Praveen', second_name: 'Rayapudi', email: 'rsivapraveen001@gmail.com', role: 0, phone_number: '8008270250')
20.times do |i|
	fn,sn = Faker::FunnyName.two_word_name.split(' ')
	User.create(first_name: fn, second_name: sn, email: Faker::Internet.email, phone_number: Faker::PhoneNumber.phone_number)
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
	"MAUN #{Faker::Number.between(1, 20)}"
]

20.times do |t|
	tm = Time.now - t*60
	10.times do |i|
		WhatsppMessage.create(data: "#{Faker::HarryPotter.quote} #{data_templates.sample}", created_at: tm, updated_at: tm, user_id: Faker::Number.between(2, 21))
	end
end