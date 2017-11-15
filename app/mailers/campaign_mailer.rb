class CampaignMailer < ApplicationMailer
  def send_campaign(campaign, contact, email)
    @campaign = campaign
    @opened_times_link = "#{ENV['HOST']}/v1/campaigns/#{campaign.id}/emails/#{email.id}/opened"
    @clicks_link = "#{ENV['HOST']}/v1/campaigns/#{campaign.id}/emails/#{email.id}/clicked"

    mail to: contact.email, subject: campaign.title
  end
end
