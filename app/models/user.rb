class User < ApplicationRecord
	has_secure_password
	has_many :authentications, dependent: :destroy
	has_many :recipes

	validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, presence: true
	validates :password_digest, length: { minimum: 5}
	validates :first_name,  presence: true
	


	# generates random token
	def User.new_token
	   SecureRandom.urlsafe_base64
	end
	

	# create_with_auth_hash will create a User object based on the information given by the provider
	 def self.create_with_auth_and_hash(authentication, auth_hash)
	   user = self.create!(
	   	 name: auth_hash["info"]["name"],
	     email: auth_hash["info"]["email"],
	     # 
	     password: SecureRandom.hex(10)
	   )
	   user.authentications << authentication
	   return user
	 end

	 # grab google to access google for user data
	 def google_token
	   x = self.authentications.find_by(provider: 'google_oauth2')
	   return x.token unless x.nil?
	 end
 
end