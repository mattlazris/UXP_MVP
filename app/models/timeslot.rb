class Timeslot < ApplicationRecord
  belongs_to :experience

  validates :start_time, presence: true, uniqueness: true
  validates :end_time, presence: true
end
