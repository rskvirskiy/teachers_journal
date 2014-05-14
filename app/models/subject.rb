class Subject < ActiveRecord::Base
  paginates_per 10

  belongs_to :user
  has_many :schedules

  validates_presence_of :name
end
