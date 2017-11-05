module Api::V1
  class TagsController < ApiController
    before_action :authenticate_user
    before_action :set_tag, only: [:show, :update, :destroy]

    # GET /v1/tags
    def index
      render json: current_user.tags.order(created_at: :desc)
    end

    # GET /v1/tags/:id
    def show
      render json: @tag
    end

    # POST /v1/tags
    def create
      tag = Tag.new(tag_params)
      if tag.save
        render json: tag, status: :ok
      else
        render json: tag.errors, status: :unprocessable_entity
      end
    end

    # PUT /v1/tags
    def update
      if @tag.update_attributes(tag_params)
        render json: @tag, status: :ok
      else
        render json: @tag.errors, status: :unprocessable_entity
      end
    end

    # DESTROY /v1/tags/:id
    def destroy
      render json: @tag.destroy
    end

    private

    def set_tag
      @tag = current_user.tags.find params[:id]
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
  end
end