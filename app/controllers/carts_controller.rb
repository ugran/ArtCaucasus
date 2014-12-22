class CartsController < ApplicationController
	before_action :authenticate_user!
  before_action :set_cart, only: [:destroy]
	
  def index
	  @carts = current_user.carts
  end

  def create
    weight = 1 #needs to be calculated by item dimensions
    shipping_cost = 150*weight
  	@cart = Cart.new(:user_id => cart_params[:user_id], :item_id => cart_params[:item_id], :item_price => Item.find_by(id: cart_params[:item_id]).price, :shipping_cost => shipping_cost)
    @cart.save
    redirect_to carts_path, notice: @cart.item.name+' has been added to your Cart.'
  end

  def destroy
    @cart.destroy
    redirect_to carts_path
  end

  private

    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.require(:cart).permit(:item_id, :user_id)
    end

end