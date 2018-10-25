class User < ApplicationRecord
	has_secure_password
	has_many :authentications, dependent: :destroy

	validates :email, uniqueness: true, presence: true
	validates :name,  presence: true
	has_many :recipes


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