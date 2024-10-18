class FileUploader < Shrine
  # plugins and uploading logic
  plugin :add_metadata
  plugin :pretty_location
  plugin :determine_mime_type, analyzer: :marcel
end
