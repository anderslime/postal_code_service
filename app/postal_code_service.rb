require './app/models/postal_code'

class PostalCodeService < Sinatra::Base

  before do
    content_type :json
  end

  get '/' do
    PostalCode.available_countries.to_json
  end

  get '/:country_code' do
    begin
      PostalCode.find_all_by_country_code(params['country_code']).to_json
    rescue PostalCode::UnknownCountry
      status 404
    end
  end

  get '/:country_code/:postal_code' do
    begin
      content_type :json
      PostalCode.find_by_postal_code(params['country_code'], params['postal_code']).to_json
    rescue PostalCode::UnknownCountry, PostalCode::UnknownCode
      status 404
    end
  end

end
