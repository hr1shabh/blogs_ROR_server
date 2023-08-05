class FollowsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def create
    @follow = current_user.follower_relationships.build(followed_id: @user.id)


    if @follow.save
      render json: @follow, status: :created
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @follow = current_user.follower_relationships.find_by(followed_id: @user.id)

    if @follow
      @follow.destroy
    else
      render json: { error: 'Follow not found.' }, status: :not_found
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
