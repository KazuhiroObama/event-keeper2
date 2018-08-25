class CreateManagements < ActiveRecord::Migration[5.1]
  def change
    create_table :managements do |t|
      t.references :event, foreign_key: true
      t.integer :participant_id

      t.timestamps
    end
    add_index  :managements, [:event_id, :participant_id], unique: true
  end
end
