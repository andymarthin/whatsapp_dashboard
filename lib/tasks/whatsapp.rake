namespace :whatsapp do
  desc "Generate Whatsapp Webhook Token"
  task webhook_token: :environment do
    puts WhatsappService::GenerateToken.call
  end
end
