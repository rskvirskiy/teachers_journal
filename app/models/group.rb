class Group < ActiveRecord::Base
  PER_PAGE = 10

  belongs_to :user

  validates_presence_of :name
end
