# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  name                 :string           default("Player")
#  ready_for_next_round :boolean
#  visitor_key          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  room_id              :bigint
#
# Indexes
#
#  index_users_on_room_id      (room_id)
#  index_users_on_visitor_key  (visitor_key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#
class User < ApplicationRecord
  MIN_USERNAME_LENGTH = 2
  MAX_USERNAME_LENGTH = 30

  belongs_to :room, optional: true
  has_many :answers
  has_many :votes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :visitor_key, uniqueness: { case_sensitive: false }, allow_nil: true
  validates :name, length: { minimum: MIN_USERNAME_LENGTH, maximum: MAX_USERNAME_LENGTH }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :async,
         :jwt_authenticatable, jwt_revocation_strategy: self

  delegate :current_round, to: :room

  def to_game_state
    state = slice(:id, :name, :ready_for_next_round)

    state.with_indifferent_access
  end
end
