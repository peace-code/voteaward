class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def me
    if user_signed_in?
      redirect_to current_user
    else
      redirect_to root_path
    end
  end
end