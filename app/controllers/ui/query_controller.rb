module UI
module Query
  def self.registered(app)
    app_get_query = lambda do
      logger.info 'Enter app_get_query'
      @action = :create
      logger.info 'Leave app_get_query'
      slim :query
    end

    app_post_query = lambda do # 1
      logger.info 'Enter app_post_query'
      logger.info params
      form = QueenshopForm.new(params)
      error_send(back, "Following fields are required: #{form.error_fields}") \
      unless form.valid?

      results = CheckProductsFromAPI.new(get_api_url('queenshop/query'), form).call
      error_send back, 'Could not find prices matching products' if (results.code != 200)

      session[:results] = results
      flash[:notice] = 'Feel free to bookmark this query and return later'
      redirect "/query/#{results.id}", 303  # redirect get '/query' - app_get_query
    end

    app_get_query_id = lambda do
      begin
        @id = params[:id]
        if session[:results]
          @results = session[:results]
          session[:results] = nil
        else
          request_url = get_api_url("queenshop/query/#{@id}")
          options =  { headers: { 'Content-Type' => 'application/json' } }
          logger.info request_url
          @results = HTTParty.get(request_url, options)
        end
        puts @results
        slim :query
      rescue => e
        logger.info e
        error_send '/queenshop/query', 'could not find api route'
      end
    end

    delete_query = lambda do
    request_url = get_api_url('queenshop/query/#{params[:id]}')
    HTTParty.delete(request_url)
    flash[:notice] = 'previos group search deleted'
    redirect '/query'
  end

    # routes
    # TODO: look for a gem that takes care of routes trailing /
    app.get '/?', &app_get_query
    app.get '/:id', &app_get_query_id
    app.post '/?', &app_post_query
    app.delete '/:id', &delete_query
  end
end
end
