module Api::V1
  class CampaignsController < ApiController
    before_action :authenticate_user
    before_action :set_campaign, except: [:index, :create]

    # GET /v1/campaigns
    def index
      render json: current_user.campaigns.all.order(created_at: :desc)
    end

    # GET /v1/campaign/:id
    def show
      render json: @campaign
    end

    # POST /v1/campaign/:id/send_emails
    def send_emails
      @campaign.send_to_contacts
      render json: { message: "La campaña fue enviada correctamente a #{@campaign.contacts.count} #{"contacto".pluralize(@campaign.contacts.count)}" }, status: :ok
    end

    # POST /v1/campaign/:id/send_email?contact_id=:contact_id
    def send_email
      contact = @campaign.contacts.find_by id: params[:contact_id]
      if contact
        @campaign.send_to(contact)
        render json: { message: "Email enviado correctamente a #{contact.full_name}" }, status: :ok
      else
        render json: { message: "Hubo un error al procesar tu solicitud." }, status: :bad_request
      end
    end

    # GET /v1/campaign/:id/email?contact_id=:contact_id
    def email
      contact = @campaign.contacts.find_by id: params[:contact_id]
      if contact
        render json: @campaign.emails.find_by(contact: contact) || Email.new
      else
        render json: { message: "Missing contact_id param" }, status: :bad_request
      end
    end

    # POST /v1/campaigns
    def create
      campaign = Campaign.new(title: campaign_params[:title], body: campaign_params[:body], spotlighted: campaign_params[:spotlighted], user: current_user)
      if campaign.save

        campaign_params[:tag_ids].each do |tag_id|
          tag = Tag.find_by id: tag_id
          campaign.tags << tag unless tag.nil? or campaign.tags.include?(tag)
        end if campaign_params[:tag_ids]

        campaign_params[:contact_ids].each do |contact_id|
          contact = Contact.find_by id: contact_id
          campaign.contacts << contact unless contact.nil? or campaign.contacts.include?(contact)
        end if campaign_params[:contact_ids]

        render json: campaign, status: :ok
      else
        render json: campaign.errors, status: :unprocessable_entity
      end
    end

    # PUT /v1/campaigns/:id
    def update
      if @campaign.update(title: campaign_params[:title], body: campaign_params[:body], spotlighted: campaign_params[:spotlighted])

        campaign_params[:tag_ids].each do |tag_id|
          tag = Tag.find_by id: tag_id
          @campaign.tags << tag unless tag.nil? or @campaign.tags.include?(tag)
        end if campaign_params[:tag_ids]

        campaign_params[:contact_ids].each do |contact_id|
          contact = Contact.find_by id: contact_id
          @campaign.contacts << contact unless contact.nil? or @campaign.contacts.include?(contact)
        end if campaign_params[:contact_ids]

        render json: @campaign, status: :ok
      else
        render json: @campaign, status: :unprocessable_entity
      end
    end

    def add_contact
      contact = Contact.find_by id: params[:contact_id]
      if @campaign.contacts.include?(contact)
        render json: false, status: :ok
      else
        @campaign.contacts << contact
        render json: contact, status: :ok
      end
    end

    def destroy_contact
      contact = Contact.find_by id: params[:contact_id]
      @campaign.contacts.destroy(contact)
    end

    # DELETE /v1/campaigns/:id
    def destroy
      render json: @campaign.destroy
    end

    # GET /v1/campaigns/search
    def search
      campaigns = current_user.campaigns.search_by_title(search_params[:title])
      render json: campaigns
    end

    private

    def set_campaign
      @campaign = current_user.campaigns.find(params[:id])
    end

    def campaign_params
      params.require(:campaign).permit(:title, :body, :spotlighted, tag_ids: [], contact_ids: [])
    end

    def search_params
      params.require(:campaign).permit(:title)
    end
  end
end