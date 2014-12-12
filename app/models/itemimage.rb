class Itemimage < ActiveRecord::Base
	belongs_to :item

	has_attached_file :image, :styles => { :small => "100" , :large => "750x750>" }

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :description, presence: true
end
