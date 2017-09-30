module Api::V1
  class TagsController < ApiController

    # GET /v1/tags
    def index
      render json: Tag.all.order(created_at: :desc)
    end

    # GET /v1/tags/:id
    def show
      render json: Tag.find(params[:id])
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
      tag = Tag.find(params[:id])
      if tag.update_attributes(tag_params)
        render json: tag, status: :ok
      else
        render json: tag.errors, status: :unprocessable_entity
      end
    end

    private

    def tag_params
      params.require(:tag).permit(:name)
    end
  end
end