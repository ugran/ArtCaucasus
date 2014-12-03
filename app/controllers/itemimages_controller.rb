class ItemimagesController < ApplicationController
	before_action :admin_user
	before_action :authenticate_user!

	respond_to :html

	def create
	    @itemimage = Itemimage.new(itemimage_params)
	    @itemimage.save
	    respond_with(Item.find_by(id: itemimage_params[:item_id]))
	end

	private

		def itemimage_params
	      params.require(:itemimage).permit(:description, :image, :item_id)
	    end

	    def admin_user
	      unless current_user.try(:admin?)
	        redirect_to :root, notice: "Only admins are authorized for this"
	      end
	    end
  
end
