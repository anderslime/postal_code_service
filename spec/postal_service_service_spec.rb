require './app/postal_code_service'
require 'rack/test'
require 'json'
require 'sinatra'

set :environment, :test

describe "The Postal Code JSON Web service" do
  include Rack::Test::Methods

  def app
    PostalCodeService
  end

  context 'in general' do

    it "returns a valid response" do
      get '/'
      last_response.should be_ok
    end

    it 'should respond with "application/json" content-type' do
      get '/'
      last_response.headers['Content-Type'].should include 'application/json'
    end

    it 'should offer at least Danish and Swedish postal codes' do
      get '/'
      JSON.parse(last_response.body).should include 'dk', 'se'
    end

  end 

  context 'for Denmark' do

    it 'should list all Danish postal codes' do
      get '/dk'
      JSON.parse(last_response.body).count.should be > 1000
    end

    context 'for individual postal codes' do

      it 'should return a postal_name for a particular code' do
        get '/dk/2500'
        JSON.parse(last_response.body).should have_key 'postal_name'
      end

      it 'should return the correct postal_name for Valby' do
        get '/dk/2500'
        JSON.parse(last_response.body)['postal_name'].should eql 'Valby'
      end

    end

  end

  context 'for a country with leading zeros in postal codes' do

    it 'should preserve the leading zero in the postal code listing' do
      get '/gt'
      JSON.parse(last_response.body).should have_key '06012'
    end

    it 'should return postal_name when looking up a postal code with leading zeros' do
      get '/gt/06012'
      JSON.parse(last_response.body)['postal_name'].should eql 'Santa Cruz Naranjo'
    end

  end


end
