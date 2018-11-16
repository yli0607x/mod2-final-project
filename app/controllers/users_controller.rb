class UsersController < ApplicationController
  before_action :find_user, to: [:show, :edit, :create, :update, :destroy]
  skip_before_action :authorized, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id:params[:id])
    @restaurant = Restaurant.find_by(id:params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      login_user(@user)
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    redirect_to @user
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :profile_picture, :user_name, :password_confirmation, :location, :phone)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
