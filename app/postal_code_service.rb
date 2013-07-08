require 'sinatra'
require './app/models/postal_code'

class PostalCodeService < Sinatra::Base

  configure do
    set :postal_coder, PostalCode.new
  end

  before do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
  end

  get '/' do
    settings.postal_coder.available_countries.to_json
  end

  get '/:country_code' do
    begin
      settings.postal_coder.find_all_by_country_code(params['country_code']).to_json
    rescue PostalCode::UnknownCountry
      status 404
    end
  end

  get '/:country_code/:postal_code' do
    begin
      content_type :json
      settings.postal_coder.find_by_postal_code(params['country_code'], params['postal_code']).to_json
    rescue PostalCode::UnknownCountry, PostalCode::UnknownCode
      status 404
    end
  end

end
