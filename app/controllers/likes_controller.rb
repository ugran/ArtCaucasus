class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index

  end

  def show
    
  end

  def new
    @like = Like.new
  end

  def create
    @like = Like.new(:item_id => like_params[:item_id], :user_id => current_user.id)
    @like.save
    @item = @like.item
    @commentbuild = Comment.new
    @itemimagebuild = Itemimage.new
    @itemimages = @item.itemimages
    render 'items/show'
  end

  def update
    @like.update(like_params)
    
  end

  def destroy
    @item = @like.item
    @like.destroy
    @commentbuild = Comment.new
    @itemimagebuild = Itemimage.new
    @itemimages = @item.itemimages
    render 'items/show'
  end

  private
    def set_like
      @like = Like.find(params[:id])
    end

    def like_params
      params.require(:like).permit(:item_id)
    end
end