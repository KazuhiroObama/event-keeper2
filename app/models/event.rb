class Event < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :organizer, class_name: :User, foreign_key: :organizer_id
  has_many :event_participant_managements
  has_many :participants, through: :event_participant_managements
  has_many :comments, dependent: :destroy
end
