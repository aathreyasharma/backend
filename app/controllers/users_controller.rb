class UsersController < ApplicationController
  before_action :current_user, only: [:update, :delete, :show]
  def index
    users = User.all
    serialized_users = UserSerializer.new(users).serializable_hash

    binding.pry

    render json: serialized_users
  end

  def create
    @user = User.create(user_params)
    render json: @user, status: 200
  end

  def update

    binding.pry

    @user.update(user_params)
    render json: @user, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :email)
  end

  def current_user
    @user = User.find(params[:id])
  end


end
