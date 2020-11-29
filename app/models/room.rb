# == Schema Information
#
# Table name: rooms
#
#  id          :bigint           not null, primary key
#  name        :string
#  password    :string
#  round_count :integer          default(3)
#  status      :integer          default("draft"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  host_id     :bigint           not null
#
# Indexes
#
#  index_rooms_on_host_id   (host_id)
#  index_rooms_on_password  (password) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (host_id => users.id)
#
class Room < ApplicationRecord
  MIN_PLAYER_COUNT = 3

  belongs_to :host, class_name: "User", foreign_key: :host_id
  has_many :users

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
  after_create :set_status

  def set_status
    public_send("#{status_check}!")
  end

  def status_check
    return :awaiting_players if users.count < MIN_PLAYER_COUNT

    :draft
  end

  private

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
