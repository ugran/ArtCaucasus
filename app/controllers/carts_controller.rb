class CartsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :create]
  before_action :set_cart, only: [:destroy]
  before_action :paypal_checkout, only: [:index]
	
  def index
    if user_signed_in?
	   @carts = current_user.carts
    else
      if params[:session_cart].present?
        unless session[:carts].present?
          session[:carts] = []
          session[:carts].push(params[:session_cart])
        else
          total = 0
          session[:carts].each do |itemid|
            total = total+Item.find(itemid).price+Item.find(itemid).shipping.to_i
          end
          unless (total+Item.find(params[:session_cart]).price+Item.find(params[:session_cart]).shipping.to_i) > 10000
            session[:carts].push(params[:session_cart])
          else
            redirect_to :back, notice: 'Your cart can not contain items with total cost of more than $10,000.'
          end
        end
      elsif params[:delete_cart_item].present?
        session[:carts].delete_at(params[:delete_cart_item].to_i)
      end
    end

    if params[:guest_email].present?
      create_guest_user(params[:guest_email])
    end

  end



  def create
    if params[:guest_email].present?
        create_guest_user(params[:guest_email])
    else
      total = 0
      authenticate_user!
      current_user.carts.each do |cart|
        total = total+cart.item_price+cart.shipping_cost
      end
      unless (total+Item.find(cart_params[:item_id]).price+Item.find(cart_params[:item_id]).shipping.to_i) > 10000
        if Item.find(cart_params[:item_id]).shipping.present?
      	 @cart = Cart.new(:user_id => cart_params[:user_id], :item_id => cart_params[:item_id], :item_price => Item.find_by(id: cart_params[:item_id]).price, :shipping_cost => Item.find_by(id: cart_params[:item_id]).shipping)
        else
         @cart = Cart.new(:user_id => cart_params[:user_id], :item_id => cart_params[:item_id], :item_price => Item.find_by(id: cart_params[:item_id]).price, :shipping_cost => 0)
        end
        @cart.save
        redirect_to carts_path, notice: @cart.item.name+' has been added to your Cart.'
      else
        redirect_to :back, notice: 'Your cart can not contain items with total cost of more than $10,000.'
      end
    end
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

    def paypal_checkout
      if user_signed_in?
        if current_user.carts.present? #&& current_user.userinfo.present?
          shipping = 0
          amount = 0
          if current_user.carts.count > 1
            item_name = current_user.carts.first.item.name
            item_number = current_user.carts.first.item.id.to_s
            current_user.carts.each_with_index do |cart, index|
              unless index == 0
                item_name = item_name+" | "+cart.item.name
                item_number = item_number+"|"+cart.item.id.to_s
              end
              shipping = shipping+cart.shipping_cost
              amount = amount+cart.item_price
            end
          else
            item_name = current_user.carts.first.item.name
            item_number = current_user.carts.first.item.id.to_s
            shipping = current_user.carts.first.shipping_cost
            amount = current_user.carts.first.item_price
          end
          item_name = item_name.truncate(127, separator: ' ')
          values = {
            :cmd => '_xclick',
            :business => 'RRHU7J5BQCG4E',
            :bn => 'Artiveria_BuyNow_WPS_US',
  #          :address_override => '1',
            :paymentaction => 'authorization',
            :no_note => '1',
            :no_shipping => '2',
            :rm => '1',
            :return => 'http://artiveria.com/orders',
            :cancel_return => 'http://artiveria.com/carts',
            :item_name => item_name,
            :item_number => item_number,
            :shipping => shipping,
            :custom => 'user-'+current_user.id.to_s,
            :invoice => 'N-'+(1_000_000 + Random.rand(10_000_000 - 1_000_000)).to_s+'-'+Time.now.to_formatted_s(:number).to_s,
            :amount => amount,
            :email => current_user.email,
  #          :address1 => current_user.userinfo.address,
  #          :city => current_user.userinfo.city,
  #          :country => current_user.userinfo.country,
  #          :first_name => current_user.userinfo.firstname,
  #          :last_name => current_user.userinfo.lastname,
  #          :state => current_user.userinfo.region,
  #          :zip => current_user.userinfo.zipcode,
            :notify_url => 'http://artiveria.com/orders'
          }
          @paypal_url = "https://www.sandbox.paypal.com/cgi-bin/webscr?"+values.map {|k,v| "#{k}=#{v}" }.join("&")
        end
      else
        if session[:guest_user_id].present? #&& current_user.userinfo.present?
          cart_items = session[:carts]
          shipping = 0
          amount = 0
          if cart_items.count > 1
            item_name = Item.find(cart_items.first).name
            item_number = Item.find(cart_items.first).id.to_s
            cart_items.each_with_index do |cart, index|
              unless index == 0
                item_name = item_name+" | "+Item.find(cart).name
                item_number = item_number+"|"+Item.find(cart).id.to_s
              end
              shipping = shipping+Item.find(cart).shipping.to_i
              amount = amount+Item.find(cart).price
            end
          else
            item_name = Item.find(cart_items.first).name
            item_number = Item.find(cart_items.first).id.to_s
            shipping = Item.find(cart_items.first).shipping.to_i
            amount = Item.find(cart_items.first).price
          end
          item_name = item_name.truncate(127, separator: ' ')
          values = {
            :cmd => '_xclick',
            :business => 'RRHU7J5BQCG4E',
            :bn => 'Artiveria_BuyNow_WPS_US',
  #          :address_override => '1',
            :paymentaction => 'authorization',
            :no_note => '1',
            :no_shipping => '2',
            :rm => '1',
            :return => 'http://artiveria.com/orders',
            :cancel_return => 'http://artiveria.com/carts',
            :item_name => item_name,
            :item_number => item_number,
            :shipping => shipping,
            :custom => 'user-'+session[:guest_user_id].to_s,
            :invoice => 'N-'+(1_000_000 + Random.rand(10_000_000 - 1_000_000)).to_s+'-'+Time.now.to_formatted_s(:number).to_s,
            :amount => amount,
            :email => User.find_by(id: session[:guest_user_id]).email,
  #          :address1 => current_user.userinfo.address,
  #          :city => current_user.userinfo.city,
  #          :country => current_user.userinfo.country,
  #          :first_name => current_user.userinfo.firstname,
  #          :last_name => current_user.userinfo.lastname,
  #          :state => current_user.userinfo.region,
  #          :zip => current_user.userinfo.zipcode,
            :notify_url => 'http://artiveria.com/orders'
          }
          @paypal_url = "https://www.sandbox.paypal.com/cgi-bin/webscr?"+values.map {|k,v| "#{k}=#{v}" }.join("&")
        end
      end
    end

end