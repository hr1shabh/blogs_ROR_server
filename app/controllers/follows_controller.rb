class FollowsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!


  def create
    begin
      @follow = current_user.follower_relationships.build(followed_id: @user.id)

      if @follow.save
        render json: @follow, status: :created
      else
        render json: { errors: @follow.errors.full_messages }, status: :unprocessable_entity
      end
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  def destroy
    begin
      @follow = current_user.follower_relationships.find_by(followed_id: @user.id)

      if @follow
        @follow.destroy
        head :no_content
      else
        render json: { error: 'Follow not found.' }, status: :not_found
      end
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
