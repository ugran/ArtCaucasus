class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index

  end

  def show
    
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(:ccontent => comment_params[:ccontent], :item_id => comment_params[:item_id], :user_id => current_user.id )
    @comment.save
    @item = @comment.item
    @commentbuild = Comment.new
    @itemimagebuild = Itemimage.new
    @itemimages = @item.itemimages
    render 'items/show'
  end

  def update
    @comment.update(comment_params)
    
  end

  def destroy
    @comment.destroy
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:ccontent, :item_id)
    end
end