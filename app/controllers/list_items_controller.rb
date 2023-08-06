class ListItemsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @list = List.find(params[:list_id])
      @post = Post.find(params[:list_item][:post_id])
      @list_item = @list.list_items.build(post: @post)
  
      if @list_item.save
        render json: @list_item
      else
        render json: { errors: @list_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Define other actions here, such as deleting list items
  
    private
  
    def list_item_params
      params.require(:list_item).permit(:post_id)
    end
  end
  