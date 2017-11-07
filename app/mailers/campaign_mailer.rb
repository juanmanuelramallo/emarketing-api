class CampaignMailer < ApplicationMailer
  def send_campaign(campaign)
    @campaign = campaign

    mail to: campaign.contacts.map(&:email), subject: campaign.title
  end
end
