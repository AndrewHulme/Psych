# == Schema Information
#
# Table name: rooms
#
#  id               :bigint           not null, primary key
#  name             :string
#  password         :string
#  round_count      :integer          default(3)
#  status           :integer          default("draft"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  current_round_id :bigint
#  host_id          :bigint           not null
#
# Indexes
#
#  index_rooms_on_current_round_id  (current_round_id)
#  index_rooms_on_host_id           (host_id)
#  index_rooms_on_password          (password) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (current_round_id => rounds.id)
#  fk_rails_...  (host_id => users.id)
#
class Room < ApplicationRecord
  MIN_PLAYER_COUNT = 3

  belongs_to :host, class_name: "User", foreign_key: :host_id
  belongs_to :current_round, class_name: "Round", foreign_key: :current_round_id, optional: true
  has_many :users
  has_many :rounds

  validates :name, :password, :status, :host_id, presence: true
  validates :name, :password, length: { minimum: 3 }
  # round_count of nil can signify infinite game length.
  validates :round_count, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :password, uniqueness: {
    case_sensitive: false,
    message: "is already taken. Please choose a different password."
  }

  enum status: { draft: 0, awaiting_players: 1, ready_to_start: 2, game_in_progress: 3 }

  before_validation :generate_name, on: :create
  before_validation :generate_password, on: :create
  before_create :add_host_to_users

  def set_status
    public_send("#{status_check}!")
  end

  def status_check
    return :ready_to_start if startable?

    :awaiting_players
  end

  def startable?
    users.count >= MIN_PLAYER_COUNT
  end

  def start_game!
    round = Round.create(room: self)
    return round.errors.full_messages if round.errors.any?

    update!(current_round: round)
    game_in_progress!
  end

  def add_user(user)
    users << user
  end

  private

  def add_host_to_users
    add_user(host)
    self.status = :awaiting_players
  end

  def generate_name
    return unless self.name.blank?

    self.name = [Faker::Verb.ing_form, Faker::Color.color_name, "Room"].map(&:capitalize).join(" ")
  end

  def generate_password
    return unless self.password.blank?

    self.password = [Faker::Ancient.titan, Faker::Verb.base].map(&:capitalize).join(" ")
    generate_password if Room.find_by(password: self.password)
  end
end
