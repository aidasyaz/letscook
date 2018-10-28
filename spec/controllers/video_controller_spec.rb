require 'rails_helper'

RSpec.describe VideoController, type: :controller do

  describe "GET #Uploads" do
    it "returns http success" do
      get :Uploads
      expect(response).to have_http_status(:success)
    end
  end

end
