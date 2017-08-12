class AttendantInfoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "attendant_#{current_user.id}_info"
  end

  def unsubscribed
    stop_all_streams
  end
end
