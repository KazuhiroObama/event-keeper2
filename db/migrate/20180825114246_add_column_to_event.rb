class AddColumnToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :management_information, :boolean, default: true, null: false
    add_column :events, :full_information, :boolean, default: true, null: false
    add_column :events, :comment_information, :boolean, default: true, null: false
    add_column :events, :cancel_information, :boolean, default: true, null: false
  end
end
