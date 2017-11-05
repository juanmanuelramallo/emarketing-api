module Api::V1
  class ContactsController < ApiController
    before_action :authenticate_user
    before_action :set_contact, only: [:show, :update, :destroy]

    # GET /v1/contacts
    def index
      render json: current_user.contacts.order(created_at: :desc)
    end

    # GET /v1/contacts/:id
    def show
      render json: @contact
    end

    # POST /v1/contacts
    def create
      contact = Contact.new(contact_params.merge(user_id: current_user.id))
      if contact.save
        render json: contact, status: :ok
      else
        render json: contact.errors, status: :unprocessable_entity
      end
    end

    # PUT /v1/contacts
    def update
      if @contact.update_attributes(contact_params)
        render json: @contact, status: :ok
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/contacts/:id
    def destroy
      render json: @contact.destroy
    end

    # GET /v1/contacts/search
    def search
      contacts = current_user.contacts.search_by_full_name_or_email(search_params[:name_or_email])
      render json: contacts

      #TODO: Search by tags
    end

    private

    def set_contact
      @contact = current_user.contacts.find params[:id]
    end

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone, :country, :city, tag_ids: [])
    end

    def search_params
      params.require(:contact).permit(:name_or_email, :tags)
    end
  end
end