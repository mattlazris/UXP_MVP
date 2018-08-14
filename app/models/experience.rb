class Experience < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  acts_as_taggable
  acts_as_taggable_on :tags

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :timeslots, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true
  validates :language, presence: true
  validates :location, presence: true
  validates :venue, presence: true, inclusion: { in: ['Indoors', 'Outdoors'] }
  validates :duration, presence: true, inclusion: {
  in: (1..5).to_a }
  validates :category, presence: true, inclusion: {
  in: ['Basketball', 'Soccer', 'Tennis', 'Others'] }
  validates :skill_level, presence: true, inclusion: {
  in: ['Beginner', 'Intermediate', 'Advanced', 'Watching'] }
  validates :capacity, presence: true, inclusion: {
  in: (1..20).to_a, message: "The capacity is too big or too small or not a number."}, numericality: { only_integer: true }

  include PgSearch
  pg_search_scope :global_search,
    against: [ :location ],
  using: {
    tsearch: { prefix: true }
  }
end
