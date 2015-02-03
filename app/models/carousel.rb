class Carousel < ActiveRecord::Base

	belongs_to :item

	has_attached_file :image, :styles => {:medium => "x500"}

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :headline, presence: true
	validates :description, presence: true

end
