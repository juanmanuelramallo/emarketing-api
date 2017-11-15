# Preview all emails at http://localhost:3000/rails/mailers/campaign_mailer
class CampaignMailerPreview < ActionMailer::Preview
  def send_campaign
    campaign = Campaign.first
    contact = campaign.contacts.first
    email = campaign.emails.find_or_initialize_by contact: contact
    CampaignMailer.send_campaign(Campaign.first, contact, email)
  end
end
