class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :admin_user, except: [:show]

  respond_to :html

  def index
      @items = Item.all
      respond_with(@items)
  end

  def show
    @commentbuild = Comment.new
    @pricerequestbuild = Pricerequest.new
    respond_with(@item, @itemimagebuild = Itemimage.new, @itemimages = @item.itemimages)
  end

  def new
    @artists = Artist.all
    @item = Item.new
    respond_with(@item)
  end

  def edit
    @artists = Artist.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    respond_with(@item)
  end

  def update
    @item.update(item_params)
    respond_with(@item)
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private
    def set_item
      @item = Item.find(params[:id])
      @og_title = @item.name.split.map(&:capitalize)*' '+' '+'By '+@item.artist.name.split.map(&:capitalize)*' '
      @og_description = @item.description
      @og_image = @item.image.url(:large)
      @og_price = @item.price.to_s
    end

    def admin_user
      unless current_user.try(:admin?)
        redirect_to :root, notice: "Only admins are authorized for this"
      end
    end

    def item_params
      params.require(:item).permit(:name, :description, :image, :artist_id, :item_type, :item_tag,:date_of_creation, :dimensions, :weight, :shipping, :sold_out , :additional_info, :price, :discount, :quantity)
    end
end