class ItemimagessController < ApplicationController


	private

		def itemimage_params
	      params.require(:itemimage).permit(:description, :image)
	    end
  
end
