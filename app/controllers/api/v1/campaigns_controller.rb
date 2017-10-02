module Api::V1
  class CampaignsController < ApiController

    # GET /v1/campaigns
    def index
      render json: Campaign.all.order(created_at: :desc)
    end

    # GET /v1/campaign/:id
    def show
      render json: Campaign.find(params[:id])
    end

    # POST /v1/campaigns
    def create
      campaign = Campaign.new(title: campaign_params[:title], body: campaign_params[:body])
      if campaign.save
        campaign_params[:tag_ids].each do |tag_id|
          campaign.tag_ids << tag_id unless campaign.tag_ids.include?(tag_id)
        end
        campaign_params[:contact_ids].each do |contact_id|
          campaign.contact_ids << contact_id unless campaign.contact_ids.include?(contact_id)
        end
        render json: campaign, status: :ok
      else
        render json: campaign, status: :unprocessable_entity
      end
    end

    # PUT /v1/tags/:id
    def update
      campaign = Campaign.find(params[:id])
      if campaign.update_attributes(title: campaign_params[:title], body: campaign_params[:body])
        campaign_params[:tag_ids].each do |tag_id|
          campaign.tag_ids << tag_id unless campaign.tag_ids.include?(tag_id)
        end
        campaign_params[:contact_ids].each do |contact_id|
          campaign.contact_ids << contact_id unless campaign.contact_ids.include?(contact_id)
        end
        render json: campaign, status: :ok
      else
        render json: campaign, status: :unprocessable_entity
      end
    end

    private

    def campaign_params
      params.require(:campaign).permit(:title, :body, :tag_ids, :contact_ids)
    end
  end
end