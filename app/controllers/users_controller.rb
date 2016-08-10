class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Your account has been created"
      redirect_to topics_path
    else
      flash[:danger] = @user.errors.full_messages
      render new_user_path
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile is Updated"
      redirect_to user_path
    else
      flash[:danger] = "Something wrong were happen"
      redirect_to user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :image)
  end
end
