class Webhook::WhatsappsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    token = params.dig("hub.verify_token")
    WhatsappService::Verify.call(token)
    render plain: params["hub.challenge"], status: :ok
  end

  def create
    begin
      WhatsappService::VerifySignature.call(request)
      WhatsappService::Webhook.call(params)
    rescue WhatsappService::Errors::SignatureError
    end
    head :ok
  end
end
