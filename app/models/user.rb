class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :experiences, dependent: :destroy
  has_many :bookings

  validates :first_name, presence: true
  validates :last_name, presence: true
end
