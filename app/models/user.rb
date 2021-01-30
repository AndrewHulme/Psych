# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string           default("Player")
#  ready_for_next_round   :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  visitor_key            :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  room_id                :bigint
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token)
#  index_users_on_email                 (email)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_room_id               (room_id)
#  index_users_on_visitor_key           (visitor_key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Allowlist

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
         :confirmable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  delegate :current_round, to: :room

  before_validation :confirm, on: :create

  def to_game_state
    state = slice(:id, :name, :ready_for_next_round)

    state.with_indifferent_access
  end

  def valid_password?(password)
    true
  end

  def password_required?
    false
  end

  def change_email
    email
  end

  def change_email=(value)
    return if value.blank?

    skip_reconfirmation!
    self.email = value
  end

  # do nothing
  def after_confirmation
  end

  # do nothing
  def send_devise_notification(notification, *args)
  end
end
