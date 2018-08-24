class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :organizer_events, class_name: :Event, foreign_key: :organizer_id, dependent: :destroy
  has_many :event_participant_managements, foreign_key: :participant_id
  has_many :participation_events, through: :event_participant_managements, source: :event
  has_many :comments, dependent: :destroy
end
