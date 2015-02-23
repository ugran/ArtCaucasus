class CarouselsController < ApplicationController
  before_action :set_carousel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :admin_user, except: [:show]

  respond_to :html

  def index
      @carousels = Carousel.all
      respond_with(@carousels)
  end

  def show
    respond_with(@carousel)
  end

  def new
    unless params[:artist_id].present?
      @items = Item.all
    else
      @items = Item.where(:artist_id => params[:artist_id])
    end
    @carousel = Carousel.new
    respond_with(@carousel)
  end

  def edit
    unless params[:artist_id].present?
      @items = Item.all
    else
      @items = Item.where(:artist_id => params[:artist_id])
    end
  end

  def create
    @carousel = Carousel.new(carousel_params)
    @carousel.save
    respond_with(@carousel)
  end

  def update
    @carousel.update(carousel_params)
    respond_with(@carousel)
  end

  def destroy
    @carousel.destroy
    redirect_to carousels_path
  end

  private
    def set_carousel
      @carousel = Carousel.find(params[:id])
    end

    def admin_user
      unless current_user.try(:admin?)
        redirect_to :root, notice: "Only admins are authorized for this"
      end
    end

    def carousel_params
      params.require(:carousel).permit(:headline, :description, :image, :item_id, :textcolor, :placerank)
    end
end