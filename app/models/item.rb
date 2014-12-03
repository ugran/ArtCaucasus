class Item < ActiveRecord::Base
	has_many :itemimages
	has_many :orders
	has_many :carts

	belongs_to :artist

	has_attached_file :image, :styles => { :small => '100x100>' ,:medium => "325x325>", :large => "750x750>" }

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :description, presence: true


	def to_param
		"#{id}-artist:#{self.artist.name}-art:#{name.gsub(/ /,"-")}"
	end

end
