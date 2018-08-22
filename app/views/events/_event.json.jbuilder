json.extract! event, :id, :title, :content, :image, :event_day, :opening_time, :ending_time, :maximum_number_of_people, :deadline_of_participant_for_event, :receptionist, :organizer_id, :created_at, :updated_at
json.url event_url(event, format: :json)
