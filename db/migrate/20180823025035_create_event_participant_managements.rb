class CreateEventParticipantManagements < ActiveRecord::Migration[5.1]
  def change
    create_table :event_participant_managements do |t|
      t.references :event, foreign_key: true
      t.integer :participant_id

      t.timestamps
    end
  end
end
