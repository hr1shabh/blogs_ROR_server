class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    render json: {
      user: @user,
      followers_count: @user.followers_count,
      following_count: @user.following_count
    }
  end
  
end
