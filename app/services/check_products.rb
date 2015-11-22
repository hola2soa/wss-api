require 'virtus'

# results from querying scraper api
class HolaScraperResult
  include Virtus.model

  attribute :code
  attribute :id
  attribute :items
  attribute :prices
  attribute :found

  def to_json
    to_hash.to_json
  end
end

# Service object to check tutorial request from API
class CheckProductsFromAPI
  def initialize(api_url, form)
    @api_url = api_url
    params = form.attributes.delete_if { |_, value| value.blank? }
    @options =  { body: params.to_json,
                  headers: { 'Content-Type' => 'application/json' }
                }
  end

  def call
    results = HTTParty.post(@api_url, @options)
    query_results = HolaScraperResult.new(results)
    query_results.code = results.code
    puts query_results
    query_results
  end
end
