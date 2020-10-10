# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'show the user' do
      get users_path
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST /users' do
    let(:user_attributes) do
      { name: 'Jonh',
        email: 'exemplo1@ex1.com',
        gender: 'Masculino',
        password: '123123',
        password_confirmation: '123123' }
    end

    it 'creates the user' do
      post '/users', params: { user: user_attributes }

      expect(response.status).to eq(302)
      user_id = User.find_by(email: 'exemplo1@ex1.com').id
      expect(request.session[:user_id] == user_id).to be(true)
    end
  end
end
