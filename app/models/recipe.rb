class Recipe < ApplicationRecord
	belongs_to :user
	# recipe has 1 image
	mount_uploader :image, RecipeImageUploader

	validates_processing_of :image
	validate :image_size_validation
 	
 	# no image greater than 500KB gets uploaded
	private
	  def image_size_validation
	    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
	  end
end
