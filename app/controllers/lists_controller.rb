class ListsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  
    def create
      @list = current_user.lists.create(list_params)
      render json: @list
    end
  
    def update
      @list = current_user.lists.find(params[:id])
      @list.update(list_params)
      render json: @list
    end
  
    def show
        @list = List.find(params[:id])
    
        if @list.user == current_user  # Check if the current user is the owner of the list
          render json: @list, include: :posts
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
  
    private
  
    def list_params
      params.require(:list).permit(:title, :description)
    end
  end
  