class PricerequestsController < ApplicationController
  before_action :set_pricerequest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:create]
  before_action :admin_user, except: [:create]

  respond_to :html

  def index

  end

  def show
    
  end

  def new
    @pricerequest = Pricerequest.new
  end

  def create
    @pricerequest = Pricerequest.new(pricerequest_params)
    @pricerequest.save
    if @pricerequest.user_id.present?
      email = @pricerequest.user.email
    else
      email = @pricerequest.email
    end
    item = @pricerequest.item_id
    OrderMailer.request_alert(email, item).deliver
    redirect_to :back
  end

  def update
    @pricerequest.update(pricerequest_params)
  end

  def destroy
    @pricerequest.destroy
    redirect_to :back
  end

  private
    def set_pricerequest
      @pricerequest = Pricerequest.find(params[:id])
    end

    def admin_user
      unless current_user.try(:admin?)
        redirect_to :root, notice: "Only admins are authorized for this"
      end
    end

    def pricerequest_params
      params.require(:pricerequest).permit(:item_id, :email, :user_id, :status)
    end
end