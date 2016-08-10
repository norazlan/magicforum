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
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :image)
  end
end