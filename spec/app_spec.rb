require_relative 'spec_helper'
require 'json'

describe 'Getting the root of the service' do
  it 'Should return ok' do
    get '/'
    last_response.must_be :ok?
    last_response.body.must_match(/queenshop/i)
  end
end

describe 'Getting cadet information' do
  it 'should return their prices' do
    get '/api/v1/cadet/10.json'
    last_response.must_be :ok?
  end

  it 'should return 404 for unknown items' do
    get "/api/v1/cadet/#{random_str(20)}.json"
    last_response.must_be :not_found?
  end
end

describe 'Checking items for prices' do
  it 'should find missing prices' do
    header = { 'CONTENT_TYPE' => 'application/json' }
    body = {
      items: ['鬆緊合身窄管褲 七色售', '基本實搭多色圓領上衣'],
      prices: ['290','250']
    }

    post '/api/v1/check', body.to_json, header
    last_response.must_be :ok?
  end

  it 'should return 404 for unknown items' do
    header = { 'CONTENT_TYPE' => 'application/json' }
    body = {
      items: [random_str(15), random_str(15)],
      prices: ['-800']
    }

    post '/api/v1/check', body.to_json, header
    last_response.must_be :not_found?
  end

  it 'should return 400 for bad JSON formatting' do
    header = { 'CONTENT_TYPE' => 'application/json' }
    body = random_str(50)

    post '/api/v1/check', body, header
    last_response.must_be :bad_request?
  end
end
