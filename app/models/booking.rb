class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :experience

  validates :user_id, presence: true
  validates :experience_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
