class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many_attached :photos

  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
end
