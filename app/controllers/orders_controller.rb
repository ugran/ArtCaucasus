class OrdersController < ApplicationController
	before_action :authenticate_user!, only: [:destroy]
  before_action :set_order, only: [:destroy]
  protect_from_forgery :except => [:create, :index]
	
  def index
    if user_signed_in?
	   @orders = Order.where(:user_id => current_user.id)
    elsif session[:guest_user_id].present?
      session[:carts] = []
      @orders = Order.where(:user_id => session[:guest_user_id])
    end
  end

   def create
    response = validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      user = User.find(params[:custom].sub(/user-/, '').to_i)
      if params[:contact_phone].present?
        phone = params[:contact_phone]
      else
        phone = ''
      end
      if user.carts.present?
        user.carts.each do |cart|
          cart.delete
        end
      end
      order = Order.create!(:description => '',
                    :additional_info => '',
                    :tracking_number => '',
                    :status => '',
                    :p_invoice_number => params[:invoice],
                    :p_gross_amount => params[:payment_gross],
                    :p_auth_amount => params[:auth_amount],
                    :p_shipping => params[:shipping],
                    :p_auth_expiration_date => params[:auth_exp],
                    :p_address_status => params[:address_status],
                    :p_payer_id => params[:payer_id],
                    :p_address_street => params[:address_street],
                    :p_payment_date => params[:payment_date],
                    :p_zipcode => params[:address_zip],
                    :p_paypal_name => params[:first_name],
                    :p_paypal_lastname => params[:last_name],
                    :p_shipping_name => params[:address_name],
                    :p_custom => params[:custom],
                    :p_country => params[:address_country],
                    :p_city => params[:address_city],
                    :p_state => params[:address_state],
                    :p_email => params[:payer_email],
                    :p_txn_id => params[:txn_id],
                    :p_item_name => params[:item_name],
                    :p_item_number => params[:item_number],
                    :p_ipn_tracking_id => params[:ipn_track_id],
                    :p_contact_phone => phone,
                    :user_id => params[:custom].sub(/user-/, '').to_i)
      item_array = params[:item_number].split('|').collect{ |s| s.to_i }
      item_array.each do |item|
        Item.find(item).update_attribute :sold_out, 1
      end
      OrderMailer.order_confirmation(user, order).deliver
      if user.name == 'guest'
        user.update_attribute :email, user.email+Time.now.strftime("%d/%m/%Y-%H:%M:%S")
      end
      # check that paymentStatus=Completed
      # check that txnId has not been previously processed
      # check that receiverEmail is your Primary PayPal email
      # check that paymentAmount/paymentCurrency are correct
      # process payment
    when "INVALID"
      # log for investigation
    else
      # error
    end
    render :nothing => true
  end 

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

#    def order_params
#      params.require(:order).permit()
#    end

  protected

    def validate_IPN_notification(raw)
      uri = URI.parse('https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate')
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = 60
      http.read_timeout = 60
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.use_ssl = true
      response = http.post(uri.request_uri, raw,
                           'Content-Length' => "#{raw.size}",
                           'User-Agent' => "My custom user agent"
                         ).body
    end

end