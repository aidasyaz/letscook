require 'rails_helper'

RSpec.describe Video, type: :model do
  video = described_class.new( 
  	link: 'https://www.youtube.com/watch?v=e-ORhEE9VVg',
  	link_format: '/\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i'
  	)

  describe "validation" do
  	it "is valid with valid attributes" do
  		expect(video).to be_valid
  	end

  	it "should not be empty" do
  		video.link = nil
  		expect(video).to_not be_valid
  	end

  	it "valid with correct youtube link format" do
  		video.link_format = 'https://www.youtu'
  		expect(video).to_not be_valid
  	end
  end
end
