require 'rails_helper'

RSpec.describe Api::V1::CarsController, type: :controller do
  describe 'GET #makes' do
    before do
      get :makes, year: 2002
    end

    it 'returns array of makes by year' do
      makes_response = JSON.parse(response.body, symbolize_names: true)
      expect(makes_response[:makes][0][:name]).to eql 'Acura'
    end

    it { should respond_with 200 }
  end
end
