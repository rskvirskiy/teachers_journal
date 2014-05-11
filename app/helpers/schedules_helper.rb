module SchedulesHelper
  def get_name(item)
    return '' unless item

    item.name
  end

  def normalized_day(day_of_week)
    I18n.t("day_of_week._#{day_of_week}")
  end

  def schedule_for(schedules, type_of_week, day_of_week)
    schedules.where(type_of_week: type_of_week, day_of_week: day_of_week)
  end

  def schedules_not_empty?
    Schedule.count != 0
  end

  def first_type_of_week
    return unless Schedule.first

    Schedule.first.type_of_week
  end

  def table_mode_schedules(schedules, day_of_week, schedules_numbers)
    schedules = schedules.where(day_of_week: day_of_week)

    schedules_numbers.inject([]) do |normalized, number|
      schedule = schedules.find_by(number: number)

      if schedule.blank?
        text =  ''
        id = nil
      else
        group   = schedule.group.name if schedule.group
        lecture_room = schedule.lecture_room.name if schedule.lecture_room

        text =  [group, lecture_room].compact.join(', ')
        id = schedule.id
      end

      normalized << { text: text, id: id }
    end
  end
end