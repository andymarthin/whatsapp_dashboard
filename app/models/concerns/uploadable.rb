module Uploadable
  extend ActiveSupport::Concern

  included do
    after_update_commit :set_media_id

    def set_media_id
      return unless file

      if file_data_previously_changed? && file_attacher.stored?
        tempfile = file.download
        response = WhatsappService::Media::Upload.call(tempfile.path)
        update(media_id: response["id"])
      end
    end
  end
end
