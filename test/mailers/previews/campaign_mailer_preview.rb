# Preview all emails at http://localhost:3000/rails/mailers/campaign_mailer
class CampaignMailerPreview < ActionMailer::Preview
  def send_campaign
    CampaignMailer.send_campaign(Campaign.first)
  end
end
