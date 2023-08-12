class CommentsController < ApplicationController
    before_action :set_post
    before_action :authenticate_user!, except: [:show, :index]
    before_action :authorize_user!, only: :destroy
  

    def index
      @comments = @post.comments
      render json: @comments
    end

    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment.destroy
    end

    def show
        @comment = @post.comments.find(params[:id])
        render json: @comment
      end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  
    def authorize_user!
      @comment = current_user.comments.find(params[:id])
      unless @comment
        render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
      end
    end
  end
  