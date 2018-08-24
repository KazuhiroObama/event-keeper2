class EventParticipantManagement < ApplicationRecord
  belongs_to :event
  belongs_to :participant, class_name: :User, foreign_key: :participant_id
end
