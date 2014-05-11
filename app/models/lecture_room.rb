class LectureRoom < ActiveRecord::Base
  PER_PAGE = 10

  belongs_to :user
  has_many :schedules

  validates_presence_of :name
end
