module Api::V1
  class CampaignsController < ApiController
    before_action :authenticate_user
    before_action :set_campaign, only: [:show, :update, :destroy]

    # GET /v1/campaigns
    def index
      render json: current_user.campaigns.all.order(created_at: :desc)
    end

    # GET /v1/campaign/:id
    def show
      render json: @campaign
    end

    # POST /v1/campaigns
    def create
      campaign = Campaign.new(title: campaign_params[:title], body: campaign_params[:body])
      if campaign.save
        campaign_params[:tag_ids].each do |tag_id|
          tag = Tag.find_by id: tag_id
          campaign.tags << tag unless tag.nil? or campaign.tags.include?(tag)
        end
        campaign_params[:contact_ids].each do |contact_id|
          contact = Contact.find_by id: contact_id
          campaign.contacts << contact unless contact.nil? or campaign.contacts.include?(contact)
        end
        render json: campaign, status: :ok
      else
        render json: campaign, status: :unprocessable_entity
      end
    end

    # PUT /v1/campaigns/:id
    def update
      if @campaign.update_attributes(title: campaign_params[:title], body: campaign_params[:body])
        campaign_params[:tag_ids].each do |tag_id|
          tag = Tag.find_by id: tag_id
          @campaign.tags << tag unless tag.nil? or @campaign.tags.include?(tag)
        end
        campaign_params[:contact_ids].each do |contact_id|
          contact = Contact.find_by id: contact_id
          @campaign.contacts << contact unless contact.nil? or @campaign.contacts.include?(contact)
        end
        render json: @campaign, status: :ok
      else
        render json: @campaign, status: :unprocessable_entity
      end
    end

    # DELETE /v1/campaigns/:id
    def destroy
      render json: @campaign.destroy
    end

    private

    def set_campaign
      @campaign = current_user.campaigns.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:title, :body, tag_ids: [], contact_ids: [])
    end
  end
end