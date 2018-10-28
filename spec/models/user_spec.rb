require 'rails_helper'


RSpec.describe User, type: :model do
	describe "validation" do
		user = described_class.new(
			first_name: 'tester',
			email: 'mail@email.com',
			password_digest: '123456')

		it "is valid with valid attributes" do
			expect(user).to be_valid
		end
		
		# password
		# unhappy
		it 'password length less than 5 characters is invalid' do
			user.password_digest = '1234'
			result = user.save

	    	expect(result).to be(false)
		end

		# happy
		it 'password should not be empty ' do
	  		user.password_digest = ''
			result = user.save

	  		expect(result).to be(false)
		end

		# email
		it 'email must be unique' do
	  		u = User.new(first_name: 'mail',email: 'mail@email.com', password_digest: '12345')
	  		u.save!

	  		expect(user).to_not be_valid
	  	end

		it 'email with invalid format is invalid' do
		  user.email = 'bugs@mail..com'
		  
		  expect(user).to_not be_valid
		end

		it "is not valid with empty email" do
			user.email = 'bugs@mail.com'

			expect(user).to_not be_valid
		end

		it "is valid without a name" do
			user.first_name = nil
			expect(user).to_not be_valid
		end
	

		describe "associations" do		
			it { should have_many(:authentications) }
			it { should have_many(:recipes) }
		end
	end
end
