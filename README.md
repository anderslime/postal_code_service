# Postal Code Service

This Sinatra app provides a JSON webservice to look up postal names by postal codes for various countries.

### Examples

To get a list of available countries listed by country codes.

    GET /
    
    Example: curl localhost
    => ['dk', 'gt', 'se']

To get a list of all postal codes and their corresponding postal names in a particular country

    GET /:country_code

    Example: curl localhost/dk
    => {"1000":"København K","1050":"København K", "1052": "København K" ... }

To get the postal name for a particular postal code in a particular country

    GET /:country_code/:postal_code

    Example: curl localhost/dk/2500
    => {"postal_name":"Valby"}
