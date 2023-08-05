class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :authorize_user!, only: [:update, :destroy]   
    def index
      
      @posts = Post.all
      render json: @posts

    end
  
    def show
      render json: @post
    end
  
    def create
        @post = current_user.posts.build(post_params)
    
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end
  
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post.destroy
    end

    def my_posts
      @user = current_user
      @my_posts = @user.posts.includes(:comments, :likes)
    end
    
  
    private

    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit(:title, :topic, :featured_image, :text, :published_datetime)
    end
  
    def authorize_user!
      unless @post.user == current_user
        render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
      end
    end
  end