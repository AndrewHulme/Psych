class BroadcastGameStateWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform(room_id)
    room = Room.find(room_id)
    RoomChannel.broadcast_to(room, room.to_game_state)
  end
end
