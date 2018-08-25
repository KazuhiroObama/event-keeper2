class Management < ApplicationRecord
  belongs_to :event
  belongs_to :participant, class_name: :User, foreign_key: :participant_id

  validates :event_id, uniqueness: {scope: :participant_id}
end
