Dir.glob('./app/controllers/**/*.rb').each { |file| require file }
require 'sinatra/base'
require 'sinatra/flash'
require 'httparty'
require 'hirb'
require 'slim'

class SinatraApp < Sinatra::Base
	  register Sinatra::Namespace
      helpers QueenshopHelper
	  enable :sessions
	  register Sinatra::Flash
	  use Rack::MethodOverride

	  set :views, File.expand_path('../../app/views', __FILE__) #ok
	  set :public_folder, File.expand_path('../../app/public', __FILE__)

	  configure do
	    Hirb.enable
	    set :session_secret, 'something'
	    set :api_ver, 'api/v1'
	  end

	  configure :development, :test do
	    set :api_server, 'http://localhost:9292'
	  end

	  configure :production do
	   # set :api_server, 'http://hola2soa-api.herokuapp.com'
	    set :api_server, 'http://powerful-basin-8880.herokuapp.com'
	  end

	  configure :production, :development do
	    enable :logging
	  end 	
	  
	  helpers do
		def current_page?(path = ' ')
		  path_info = request.path_info
		  path_info += ' ' if path_info == '/'
		  request_path = path_info.split '/'
		  request_path[1] == path
		end
	  end
	  
	  
	  
	  
	app_get_show = lambda do
		@item=params[:item]
		if @item
		  redirect "/show/#{@item}"
		  return nil
		end
		 logger.info  'My name is frank'
		slim :show
	
	end
	
	app_get_show_item = lambda do
		@item = params[:item]
		@products = get_items(@item)

		if @item && @products.nil?
		  flash[:notice] = 'item not found' if @products.nil?
		  redirect '/show'
		  return nil
		end

		slim :show
	end
	
	
	app_get_query = lambda do

		@action = :create
		slim :query

	end
  
  
  
	app_post_query  = lambda do  #1
			
		request_url = "#{settings.api_server}/#{settings.api_ver}/query"

		prices = params[:prices]
		pages = params[:pages]
		items = params[:items]
		
		params_h = {
		  prices: prices,
		  pages: pages,
		  items: items
		}

		options =  {  body: params_h.to_json,
					  headers: { 'Content-Type' => 'application/json' }
				   }
	
	   
		result = HTTParty.post(request_url, options)   #post http://powerful-basin-8880.herokuapp.com/api/v1/query"  #Application error

=begin	
		if (result.code != 200)
		  flash[:notice] = 'Could not process your request'
		  redirect '/query'
		  return nil
		end

		id = result.request.last_uri.path.split('/').last
		session[:results] = result.to_json
		session[:action] = :create
		
		
	    redirect "/query/#{id}"
=end 
	end
	
	
	app_get_query_id = lambda do
		if session[:action] == :create
		  @results = JSON.parse(session[:results])
		else
		  request_url = "#{settings.api_server}/#{settings.api_ver}/query/#{params[:id]}"
		  options =  { headers: { 'Content-Type' => 'application/json' } }
		  @results = HTTParty.get(request_url, options)
		  if @results.code != 200
			flash[:notice] = 'cannot find item of query'
			redirect '/query'
		  end
		end

		@id = params[:id]
		@action = :update
		@prices = @results['prices']
		@pages = @results['pages']
		@items = @results['items']
		
		slim :query
	end
	
	app_delete_query_id = lambda do
		request_url = "#{settings.api_server}/#{settings.api_ver}/query/#{params[:id]}"
		HTTParty.delete(request_url)
		flash[:notice] = 'record of query deleted'
		redirect '/query'
	end
	
	
	
	get '/show', &app_get_show
	get '/show/:item', &app_get_show_item
	get '/query', &app_get_query
	post '/query', &app_post_query
	get '/query/:id', &app_get_query_id
	delete '/query/:id', &app_delete_query_id


	#Web API
	api_root = lambda do
		  'Hello,Queenshop is up and working.  Please see documentation at its ' \
		  '<a href="https://github.com/hola2soa/QueenShopWebApi">' \
		  'Github repo - master branch</a>'
	end

    api_show = lambda do
          content_type :json
          get_items(params[:item]).to_json
		  
    end
		
		
    api_post_query = lambda do		
			
		 logger.info  'Nice to meet you'
          content_type :json 
          begin
            req = JSON.parse(request.body.read)
            logger.info req
          rescue #=> e
            logger.error "Error: #{e.message}"
            halt 400
          end

          request = Request.new(
            items: req['items'].to_json,
            prices: req['prices'].to_json,
            pages: req['pages'].to_json
          )

          if request.save
            status 201
            redirect "/api/v1/query/#{request.id}", 303
          else
            logger.error 'Error saving request to database'
            halt 500, 'Error saving request request to the database'
          end
  
    end

		
     api_get_query_id = lambda do
        	
          content_type :json
          begin
            request = Request.find(params[:id])
            items = JSON.parse(request.items)
            prices = JSON.parse(request.prices)
            pages = JSON.parse(request.pages)
          rescue
            logger.error 'Error while fetching request from database'
            halt 400
          end

          begin
            results = check_items(items, prices, pages).to_json
          rescue
            logger.error 'Lookup of Queenshop failed'
            halt 500, 'Lookup of Queenshop failed'
          end

          { id: request.id, items: items,
            prices: prices, pages: pages
          }.to_json

    end
		
		api_delete_query = lambda do
			request = Request.destroy(params[:id])
			status(request > 0 ? 200 : 404)
		end
		
		
		get '/api/v1/', &api_root
        get '/api/v1/:item', &api_show
        get '/api/v1/query/:id', &api_get_query_id
        post '/api/v1/query', &api_post_query
	    delete '/api/v1/query/:id', &api_delete_query
	
	
	  
	  namespace '/' do 
		register Api::V1::ApplicationController
	  end

	#  namespace '/api' do
	#	namespace '/v1' do
	#	  namespace '/queenshop' do
	#		register Api::V1::QueenshopController
	#	  end
	#	end
	#  end
end
