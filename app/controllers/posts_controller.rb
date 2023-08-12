class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show, :post_by_title, :top_posts, :recommended_posts, :most_commented_posts, :posts_by_date, :posts_by_topic, :more_posts_by_user]
    before_action :authorize_user!, only: [:update, :destroy]   
    
    def index
      @posts = Post.where(status: "published").order(created_at: :desc)
      render json: @posts
    end
  
    def show
      if @post.draft? && (current_user.nil? || @post.user != current_user)
        render json: { error: "You do not have permission to view this draft post." }, status: :unauthorized
      else
        @post.increment!(:view_count)
        render json: @post
      end
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if params[:publish]
        @post.status = "published"
      else
        @post.status = "draft"
      end
  
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @post.update(post_params)
        if params[:publish] && @post.draft?
          @post.update(status: 'published')
        end
        
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post.destroy
    end

    def bookmark
      @post = Post.find(params[:id])
    
      if @post.published?
        current_user.bookmarks.create(post: @post)
        render json: @post
      else
        render json: { error: "You can only bookmark published posts." }, status: :unprocessable_entity
      end
    end
    
  
    def bookmarked_posts
      @user = current_user
      @bookmarked_posts = @user.bookmarked_posts
      render json: @bookmarked_posts
    end

    def delete_bookmark
      @post = Post.find(params[:id])
      bookmark = current_user.bookmarks.find_by(post: @post)
      
      if bookmark
        bookmark.destroy
        render json: { message: 'Bookmark deleted successfully' }
      else
        render json: { error: 'Bookmark not found' }, status: :not_found
      end
    end

    def my_posts
      @user = current_user
      @my_posts = @user.posts.includes(:comments, :likes)
    end
    def top_posts
      @top_posts = Post
                    .published
                    .left_joins(:likes)
                    .group(:id)
                    .order('COUNT(likes.id) DESC')
                    .limit(10)
    
      render json: @top_posts
    end
    
    def more_posts_by_user
      author_id = params[:author_id]
      @more_posts = Post.published
                       .where(user_id: author_id)
                       .order(created_at: :desc)
                       .limit(10)
      render json: @more_posts
    end
    
    def posts_by_topic
      topic = params[:topic]
      @posts_by_topic = Post.published
                           .where(topic: topic)
                           .order(created_at: :desc)
                           .limit(10)
      render json: @posts_by_topic
    end
    
    def recommended_posts
      # Retrieve published posts ordered by likes count in descending order
      @recommended_posts = Post.published
                              .left_joins(:likes)
                              .group(:id)
                              .order('COUNT(likes.id) DESC')
                              .limit(10)
      render json: @recommended_posts
    end
    
    def most_commented_posts
      @most_commented_posts = Post.published
                              .left_joins(:comments)
                              .group(:id)
                              .order('COUNT(comments.id) DESC')
                              .limit(10)
    end
    def posts_by_date
      start_date = params[:start_date]
      end_date = params[:end_date]
      
      # Retrieve published posts within the specified date range
      @posts_by_date = Post.published
                         .where(published_datetime: start_date..end_date)
                         .order(created_at: :desc)
                         
      render json: @posts_by_date
    end
    def post_by_title
      title = params[:title]
      @posts = Post.where("title LIKE ?", "%#{title}%").where(status: "published").order(created_at: :desc)
      render json: @posts
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