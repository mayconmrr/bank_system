require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /users" do
    it "show the user" do
      get users_path
      expect(response).to have_http_status(302)
    end
  end

  describe "POST /users" do
    let(:attributes) {{:name => "Jonh", :email => "exemplo1@ex1.com", :gender => "Masculino", :password => "123123", :password_confirmation => "123123" }}
    let(:params) {{format: :json, user: attributes}}

    it "creates the user" do
      post "/survivors", params

      expect(response.status).to eq 201

      body = JSON.parse(response.body)
      expect(body['name']).to eq "Jonh"
      expect(body['email']).to eq "exemplo1@ex1.com"
      expect(body['gender']).to eq "Masculino"  
      expect(body['password']).to eq "123123"  
      expect(body['password_confirmation']).to eq "123123"  
    end
  end
end
