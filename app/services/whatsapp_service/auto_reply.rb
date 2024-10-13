module WhatsappService
  class AutoReply < Base
    def initialize(params)
      @params = params
      super
    end

    def call
    end

    private



    def list
      @list ||= JSON.parse bot_file
    end
  end
end
