class Schedule < ActiveRecord::Base
  PER_PAGE = 10
  belongs_to :user

  belongs_to :lecture_room
  belongs_to :subject
  belongs_to :group

  validates_presence_of :type_of_week, :number, :day_of_week
  validates_numericality_of :number, less_than_or_equal_to: 7, greater_than: 0
  validates_numericality_of :day_of_week, less_than_or_equal_to: 7, greater_than: 0

  def self.get_uniq_values_of(column, user = nil)
    return [] unless self.column_names.include? column.to_s
    return pluck(column).uniq unless user

    where(user_id: user.id).pluck(column).uniq
  end

  def self.get_max_value_of_number
    get_uniq_values_of(:number).max
  end
end
