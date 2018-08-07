class Experience < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true
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
