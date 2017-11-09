class CampaignMailer < ApplicationMailer
  def send_campaign(campaign, contact)
    @campaign = campaign

    mail to: contact.email, subject: campaign.title
  end
end
