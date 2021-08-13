class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many_attached :photos

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_title_username,
    against: {
      title: "A"
    },
    associated_against: {
      user: {
        username: "B"
      },
    },
    using: {
      tsearch: { prefix: true }
    }
end
