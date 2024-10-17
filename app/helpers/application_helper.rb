module ApplicationHelper
  def reset_modal_frame
    turbo_stream.update :remote_modal, ""
  end
end
