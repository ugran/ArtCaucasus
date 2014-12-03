class Artist < ActiveRecord::Base
	has_many :items
	
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "200x200>" }

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :description, presence: true

	def to_param
		"#{id}-artist:#{name.gsub(/ /,"-")}"
	end

end
