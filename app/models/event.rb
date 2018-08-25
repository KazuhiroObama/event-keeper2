class Event < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :organizer, class_name: :User, foreign_key: :organizer_id
  has_many :managements, dependent: :destroy
  has_many :participants, through: :managements
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  validates :opening_time, presence: true
  validates :maximum_number_of_people, presence: true
end
