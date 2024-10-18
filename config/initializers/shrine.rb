require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache", directory_permissions: 0o755,
                                                   permissions: 0o644),
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads", directory_permissions: 0o755,
                                                   permissions: 0o644)
}

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :remote_url, max_size: 20*1024*1024
