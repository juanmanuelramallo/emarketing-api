module Api::V1
  class ContactsController < ApiController

    # GET /v1/contacts
    def index
      render json: Contact.all.order(created_at: :desc)
    end

    # GET /v1/contacts/:id
    def show
      render json: Contact.find(params[:id])
    end

    # POST /v1/contacts
    def create
      contact = Contact.new(contact_params)
      if contact.save
        render json: contact, status: :ok
      else
        render json: contact.errors, status: :unprocessable_entity
      end
    end

    # PUT /v1/contacts
    def update
      contact = Contact.find(params[:id])
      if contact.update_attributes(contact_params)
        render json: contact, status: :ok
      else
        render json: contact.errors, status: :unprocessable_entity
      end
    end

    # GET /v1/contacts/search
    def search
      render json: Contact.search_by_full_name_or_email(search_params[:name_or_email])

      #TODO: Search by tags
    end

    private

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone, :country, :city, :tags, :campaigns)
    end

    def search_params
      params.require(:contact).permit(:name_or_email, :tags)
    end
  end
end