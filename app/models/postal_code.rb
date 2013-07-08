require 'yaml'

class PostalCode

  class UnknownCountry < RuntimeError; end;
  class UnknownCode < RuntimeError; end;

  def initialize
    @postal_codes = {}
  end

  def available_countries
    Dir.glob("#{self_path}/postal_code_data/*").collect do |file|
      file.match(/\/(\w+).yaml/)[1]
    end
  end

  def find_by_postal_code(country_code, postal_code)
    postal_name = find_all_by_country_code(country_code)[postal_code]
    raise UnknownCode if postal_name.nil?
    {postal_name: postal_name}
  end

  def find_all_by_country_code(country_code)
    @postal_codes[country_code] ||= process_postal_code_array(load_file(country_code))
  end

  private

  def load_file(country_code)
    YAML.load_file("#{self_path}/postal_code_data/#{country_code}.yaml").sort_by { |postal_pair| postal_pair['postal_codes'] }
  rescue Errno::ENOENT
    raise UnknownCountry
  end

  def process_postal_code_array(postal_codes)
    postal_code_hash = {}
    postal_codes.each do |code|
      postal_code_hash[code['postal_code']] = code['postal_name']
    end
    postal_code_hash
  end

  def self_path
    File.dirname(__FILE__)
  end

end
