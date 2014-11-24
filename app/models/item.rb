class Item < ActiveRecord::Base
	has_many :itemimages
	belongs_to :artist

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
