class RelationshipsController < ApplicationController
    before_action :set_user
    before_action :authenticate_user!
  
    def create
      @relationship = current_user.following_relationships.build(followed_id: @user.id)
  
      if @relationship.save
        render json: @relationship, status: :created
      else
        render json: @relationship.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @relationship = current_user.following_relationships.find_by(followed_id: @user.id)
      if @relationship
        @relationship.destroy
        redirect_to destroy_relationship_path(@user), status: :no_content
      else
        render json: { error: 'Relationship not found.' }, status: :not_found
      end
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  end
  