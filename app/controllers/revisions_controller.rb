class RevisionsController < ApplicationController
    before_action :set_revision, only: [:show]
  
    def show
      render json: @revision
    end
  
    private
  
    def set_revision
      @revision = Revision.find(params[:id])
    end
  end
  