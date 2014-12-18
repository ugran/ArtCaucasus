class Item < ActiveRecord::Base
	has_many :itemimages
	has_many :orders
	has_many :carts
	has_many :comments
	has_many :likes

	belongs_to :artist

	has_attached_file :image, :styles => { :small => '100' ,:medium => "300x300>", :large => "750x750>" }

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :description, presence: true


	def to_param
		"#{id}-artist:#{self.artist.name}-art:#{name.gsub(/ /,"-")}"
	end

end
