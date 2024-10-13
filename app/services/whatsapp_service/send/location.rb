module WhatsappService::Send
  class Location < Base
    def initialize(to, latitude, longitude, address: nil, name: nil)
      @to = to
      @latitude = latitude
      @longitude = longitude
      @address = address
      @name = name
      super
    end

    def call
      raise WhatsappService::Error, "Latitude is required" if latitude.nil?
      raise WhatsappService::Error, "Longitude is required" if longitude.nil?

      super
    end

    private
    attr_reader :latitude, :longitude, :address, :name

    def payload
      {
        location: {
          latitude:,
          longitude:,
          address:,
          name:
        }
      }
    end

    def type
      "location"
    end
  end
end
