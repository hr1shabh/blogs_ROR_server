class LikesController < ApplicationController
    before_action :set_post
    before_action :authenticate_user!, except: [:show_users, :count]
  
    def create
      begin
        @like = @post.likes.build(user: current_user)
      
        if @like.save
          render json: @like, status: :created
        else
          render json: { errors: @like.errors.full_messages }, status: :unprocessable_entity
        end
      rescue => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
    
  
    def destroy
      @like = @post.likes.find_by(user: current_user)
      if @like
        @like.destroy
      else
        render json: { error: 'Like not found.' }, status: :not_found
      end
    end

    def show_users
        users_who_liked = @post.likes.map { |like| like.user }
        render json: users_who_liked, status: :ok
      end

    def count
        likes_count = @post.likes.count
        render json: { count: likes_count }, status: :ok
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  end
  