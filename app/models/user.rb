class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy
  has_many :services, dependent: :destroy
  # has_many :clients_booking, through: :services, source: :bookings
  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
end
