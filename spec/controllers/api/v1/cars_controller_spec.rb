require 'rails_helper'

RSpec.describe Api::V1::CarsController, type: :controller do
  render_views

  describe 'GET #makes' do
    before do
      get :makes, year: 2002, format: :json
    end

    it 'returns array of makes by year' do
      makes_response = json_response
      expect(makes_response[0][:name]).to eql 'Acura'
    end

    it { should respond_with 200 }
  end

  describe 'GET #maintenance' do
    before do
      get :maintenance, year: 2002, make: 'honda', model: 'accord', format: :json
    end

    it 'returns details of car including maintenance report' do
      maintenance_response = json_response
      expect(maintenance_response[:model]).to eql 'Accord'
    end
  end
end
