class UserinfosController < ApplicationController
	before_action :authenticate_user!
  before_action :set_userinfo

  def index
    unless current_user.userinfo.present?
      @userinfobuild = Userinfo.new
    else
      @userinfobuild = current_user.userinfo
    end
  end

  def create
  	@userinfo = Userinfo.new(:firstname => userinfo_params[:firstname], :lastname => userinfo_params[:lastname], :country => userinfo_params[:country], :phone => userinfo_params[:phone], :address => userinfo_params[:address], :zipcode => userinfo_params[:zipcode], :user_id => current_user.id)
    @userinfo.save
    redirect_to :back
  end

  def update
    current_user.userinfo.update(userinfo_params)
    redirect_to :back
  end


  private

    def set_userinfo
      @userinfo = Userinfo.find_by(user_id: current_user.id)
    end

    def userinfo_params
      params.require(:userinfo).permit(:firstname, :lastname, :country, :phone, :address, :zipcode)
    end

end