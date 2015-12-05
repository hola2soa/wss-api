module UI
module Show
  def self.registered(app)
    app_get_show = lambda do
    #  @item = params[:item]
    @item="s"
      if @item
        logger.info 'redirected to get items'
        redirect "/show/#{@item}"
        return nil
      end
      logger.info 'load show'
      logger.info @item
      slim :main_pane
    end

    app_get_show_item = lambda do
      begin
        @item = params[:item]

        if session[:results]
          @results = session[:results]
          session[:results] = nil
        else
          request_url = get_api_url("queenshop/#{@item}")
          logger.info '+++++++++++'
          logger.info request_url
          options =  { headers: { 'Content-Type' => 'application/json' } }
      #    @results = HTTParty.get(request_url, options)
        end
        logger.info "after HTTParty.get"
        @products = @results
        @linechartdata={"100~200"=>4,"200~300"=>6,"300~400"=>8,"400~500"=>10,"500~600"=>2}
        logger.info "after linechartdata"
        logger.info @linechartdata
        slim :list_results
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
