module Api::V1
  class CampaignEmailsController < ApiController
    before_action :authenticate_user, except: [:opened, :clicked]
    before_action :set_campaign
    before_action :set_email

    def index
      render json: @campaign.emails
    end

    def opened
      @email.opened!
      render json: '', status: :ok
    end

    def clicked
      @email.clicked!
      render json: '', status: :ok
    end

    private

    def set_campaign
      @campaign = Campaign.find params[:campaign_id]
    end

    def set_email
      @email = @campaign.emails.find params[:id]
    end

    def email_params
      params.require(:email).permit(:opened_times, :clicks)
    end
  end
end