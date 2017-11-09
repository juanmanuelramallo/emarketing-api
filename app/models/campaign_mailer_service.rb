class CampaignMailerService
  attr_accessor :campaign, :contact, :email

  def initialize(campaign:, contact:)
    @campaign = campaign
    @contact = contact
    @email = Email.find_or_initialize_by campaign: campaign, contact: contact
  end

  def deliver_now
    CampaignMailer.send_campaign(campaign, contact).deliver_now
    email.update sent_times: (email.sent_times || 0) + 1
  end
end