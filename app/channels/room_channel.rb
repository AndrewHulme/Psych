class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find params[:room]
    stream_for room
    # RoomChannel.broadcast_to(room_object, data)

    # or
    # stream_from "room_#{params[:room]}"
    # # ActionCable.server.broadcast("room_#{a_room_id_here}", data)
  end
end
