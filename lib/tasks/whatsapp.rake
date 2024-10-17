namespace :whatsapp do
  desc "Generate Whatsapp Webhook Token"
  task webhook_token: :environment do
    puts WhatsappService::GenerateToken.call
  end

  desc "Register Phone Number"
  task register: :environment do
    pin = ENV["pin"]
    if pin.present?
      WhatsappService::Registration::Register.call(pin)
    else
      puts "Pin is required"
    end
  end
end
