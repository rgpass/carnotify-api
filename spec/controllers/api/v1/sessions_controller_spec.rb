require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe 'POST #create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    context 'correct credentials' do
      before(:each) do
        credentials = { email: @user.email, password: '12345678' }
        post :create, { session: credentials }
      end

      it 'returns the user record corresponding to the given credentials' do
        @user.reload
        expect(json_response[:remember_token]).to eql @user.remember_token
      end

      it { should respond_with 200 }
    end

    context 'incorrect credentials' do
      before(:each) do
        credentials = { email: @user.email, password: 'invalidpassword' }
        post :create, { session: credentials }
      end

      it 'renders an errors json' do
        expect(json_response[:errors]).to eql 'Invalid email or password'
      end

      it { should respond_with 422 }
    end
  end

  # Not necessary to have this since the back end doesn't handle session management
  # however this way we expire the current token.
  describe 'DELETE #destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user, no_capybara: true#, store: false
      delete :destroy, { session: { remember_token: @user.remember_token } }
    end

    it { should respond_with 204 }
  end

end