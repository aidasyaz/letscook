require 'rails_helper'

describe "session", :type => :feature do
	before :each do
		User.new(first_name: 'test', password_digest: '123456')
	end

	  it "signs up user" do
	    visit "/users/new"
	    fill_in "Username", :with => "test"
	    fill_in "Password", :with => "123456"
	    fill_in "Confirm Password", :with => "123456"
	    click_button "Sign up"

	    expect(page).to have_content 'Log In'
	  end

	  

end