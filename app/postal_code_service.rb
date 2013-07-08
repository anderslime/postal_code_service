require 'sinatra'
require './app/models/postal_code'

class PostalCodeService < Sinatra::Base

  before do
    headers 'Access-Control-Allow-Origin' => '*'
    content_type :json
  end

  get '/' do
    postal_code.available_countries.to_json
  end

  get '/:country_code' do
    begin
      postal_code.find_all_by_country_code(params['country_code']).to_json
    rescue PostalCode::UnknownCountry
      status 404
    end
  end

  get '/:country_code/:postal_code' do
    begin
      content_type :json
      postal_code.find_by_postal_code(params['country_code'], params['postal_code']).to_json
    rescue PostalCode::UnknownCountry, PostalCode::UnknownCode
      status 404
    end
  end

  def postal_code
    PostalCode.instance
  end

end
