user = User.create(email: 'test@example.com', password: 'qweqweqwe', password_confirmation: 'qweqweqwe')

(1..12).each { |x| user.subjects.create(name: "SPO#{x}") }
(1..12).each { |x| user.groups.create(name: "SP#{x}") }
(30..42).each { |x| user.lecture_rooms.create(name: "3.#{x}") }

(1..12).each do |x|
	user.timesheets.create do |t|
		t.date         = Date.today
		t.group        = "SP#{x}"
		t.subject      = "SPO#{x}"
		t.theme        = "Quick Development #{x}"
		t.type_of_work = 'lecture'
		t.hours        = 10/x
	end
end

(1..5).each do |day_of_week|
	(1..5).each do |number|
		user.schedules.create(type_of_week:    'up', day_of_week: day_of_week,
		                      number:          number, group_id: Random.rand(1..5), subject_id: Random.rand(1..5),
		                      lecture_room_id: Random.rand(1..5))
	end
end

(1..5).each do |day_of_week|
	(1..5).each do |number|
		user.schedules.create(type_of_week:    'down', day_of_week: day_of_week,
		                      number:          number, group_id: Random.rand(1..5), subject_id: Random.rand(1..5),
		                      lecture_room_id: Random.rand(1..5))
	end
end
