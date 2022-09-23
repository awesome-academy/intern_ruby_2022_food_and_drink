class RoomChannel < ApplicationCable::Channel
  include RoomsHelper
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    data["user_name"] = User.find(data["user_id"]).name
    ActionCable.server.broadcast "room_channel", data
    current_user.messages.create! content: data["message"],
                                  user_id: data["user_id"],
                                  room_id: data["room_id"]
  end
end
