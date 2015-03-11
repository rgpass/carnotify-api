require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #show' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      get :show, id: @user.id, format: :json
    end

    it 'returns the information about a reporter on a hash' do
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end

    it { should respond_with 200 }
  end

  describe 'POST #create' do
    context 'when successfully created' do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }, format: :json
      end

      it 'renders json representation of the user just created' do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it 'signs in users' do
        user_response = json_response
        digested_token = User.digest(response.cookies['remember_token'])
        expect(digested_token).to eq user_response[:remember_token]
      end

      it { should respond_with 201 }
    end

    context 'when not created' do
      before(:each) do
        @invalid_user_attributes = FactoryGirl.attributes_for(:user, email: nil)
        post :create, { user: @invalid_user_attributes }, format: :json
      end

      it 'renders an errors json' do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it 'renders json errors on why user could not be created' do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      # 422 - Unprocessable Entity
      # Everything is formatted correctly in the request, but could not be processed
      it { should respond_with 422 }
    end
  end

  describe 'PUT/PATCH #update' do
    context 'when successfully updated' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        patch :update, { id: @user.id, user: { email: 'newemail@example.com' } }, format: :json
      end

      it 'renders json representation of the user just updated' do
        user_response = json_response
        expect(user_response[:email]).to eql 'newemail@example.com'
      end

      it { should respond_with 200 }
    end

    context 'when not updated' do
      before(:each) do
        @user = FactoryGirl.create(:user)
        patch :update, { id: @user.id, user: { email: 'bademail.com' } }, format: :json
      end

      it 'renders an errors json' do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it 'renders json errors on why user could not be updated' do
        user_response = json_response
        expect(user_response[:errors][:email]).to include 'is invalid'
      end

      it { should respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      delete :destroy, { id: @user.id }, format: :json
    end

    # Successful, no content
    it { should respond_with 204 }
  end
end
