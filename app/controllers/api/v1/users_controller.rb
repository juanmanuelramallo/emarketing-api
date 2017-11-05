module Api::V1
  class UsersController < ApiController
    before_action :authenticate_user, except: [:create]

    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: :ok
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :last_name, :email, :password, :phone, :country, :city)
    end

  end
end