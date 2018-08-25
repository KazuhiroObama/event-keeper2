class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :organizer_events, class_name: :Event, foreign_key: :organizer_id, dependent: :destroy
  has_many :managements, foreign_key: :participant_id, dependent: :destroy
  has_many :participation_events, through: :managements, source: :event

  # usernameのバリデーション
  validates :name,
    uniqueness: { case_sensitive: :false },
    length: { minimum: 4, maximum: 20 },
    format: { with: /\A[a-z0-9]+\z/, message: "ユーザー名は半角英数字です"}
end
