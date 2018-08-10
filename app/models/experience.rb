class Experience < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  acts_as_taggable
  acts_as_taggable_on :tags

  belongs_to :user
  has_many :bookings
  has_many :timeslots

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true
  validates :language, presence: true
  validates :location, presence: true
  validates :duration, presence: true, inclusion: {
  in: (1..5).to_a }
  validates :category, presence: true, inclusion: {
  in: ['Food & Drink', 'Classes & Workshops', 'Unique tours', 'Sports & Outdoors'] }
  validates :capacity, presence: true, inclusion: {
  in: (1..20).to_a, message: "The capacity is too big or too small or not a number."}, numericality: { only_integer: true }

  include PgSearch
  pg_search_scope :global_search,
    against: [ :name, :description ],
  associated_against: {
    user: [ :first_name, :last_name, :description ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
