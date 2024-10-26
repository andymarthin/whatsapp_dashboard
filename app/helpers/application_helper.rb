module ApplicationHelper
  def reset_modal_frame
    turbo_stream.update :remote_modal, ""
  end

  def render_turbo_stream_flash_message
    turbo_stream.prepend "notification-flash", partial: "layouts/notification"
  end
end
