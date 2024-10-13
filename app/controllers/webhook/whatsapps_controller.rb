class Webhook::WhatsappsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    token = params.dig("hub.verify_token")
    WhatsappService::Verify.call(token)
    render plain: params["hub.challenge"], status: :ok
  end

  def create
    WhatsappService::VerifySignature.call(request)
    WhatsappService::Webhook.call(params)
    head :ok
  end
end
