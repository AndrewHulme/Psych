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
#  index_rooms_on_host_id  (host_id)
#
# Foreign Keys
#
#  fk_rails_...  (host_id => users.id)
#
class Room < ApplicationRecord
  belongs_to :host, class_name: "User", foreign_key: :host_id
  has_many :users

  validates :name, :password, :status, :host_id, presence: true
  # round_count of nil can signify infinite game length.
  validates :round_count, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  enum status: { draft: 0, awaiting_players: 1, ready_to_start: 2, game_in_progress: 3 }
end
