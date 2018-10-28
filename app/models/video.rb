class Video < ApplicationRecord
	
	link_format = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  	validates :link, format:link_format

end

