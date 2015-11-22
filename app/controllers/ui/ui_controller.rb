module UI
module Show
  def self.registered(app)
    app_get_show = lambda do
      @item = params[:item]
      if @item
        logger.info 'redirected to get items'
        redirect "/show/#{@item}"
        return nil
      end
      logger.info 'load show'
      slim :show
    end

    app_get_show_item = lambda do
      begin
        @item = params[:item]

        if session[:results]
          @results = session[:results]
          session[:results] = nil
        else
          request_url = get_api_url("queenshop/#{@item}")
          options =  { headers: { 'Content-Type' => 'application/json' } }
          @results = HTTParty.get(request_url, options)
        end
        @products = @results
        slim :show
      rescue => e
        logger.info e
        error_send '/show', 'Could not find query -- perhaps it was deleted?'
      end
    end

    # routes
    app.get '/?', &app_get_show
    app.get ':item', &app_get_show
    app.get '/:item', &app_get_show_item
  end
end
end
