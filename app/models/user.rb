class User < ApplicationRecord
	has_secure_password
	validates :email, uniqueness: true, presence: true

	# generates random token
	def User.new_token
	   SecureRandom.urlsafe_base64
	end
	
end
