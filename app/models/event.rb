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

  def self.future
    # イベントを、開始時間の昇順で並べ替え。開始時間が現在時間より後のイベントのみ取得。
    order(:opening_time).select { |event| event if Time.zone.now < event.opening_time }
  end

  def self.past
    # イベントを、開始時間の昇順で並べ替え。開始時間が現在時間以前のイベントのみ取得。
    order(:opening_time).select { |event| event if Time.zone.now >=  event.opening_time }
  end

  def current_user_management_events(event)
    current_user.managements.find_by(event_id: event.id) if current_user.present?
  end
end
