module WhatsappService
  class AutoReply < Base
    def initialize(params)
      @params = params
      super
    end

    def call
    end

    private

    def list_file
      @list_file ||= File.open(Rails.root("bot.json"))
    end

    def list
      @list ||= JSON.parse list_file
    end
  end
end
