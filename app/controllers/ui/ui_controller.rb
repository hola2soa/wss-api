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
      slim :main_pane
    end

    app_get_show_item = lambda do
      begin
        @item = params[:item]
        logger.info @item
        if session[:results]
          @results = session[:results]
          session[:results] = nil
        else
          options =  { headers: { 'Content-Type' => 'application/json' } }
          request_url = get_api_url("?store=queenshop&keyword=#{URI.escape(@item)}")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=joyceshop&keyword=#{URI.escape(@item)}")
          logger.info request_url
          @results2 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&keyword=#{URI.escape(@item)}")
          logger.info request_url
          @results3 = HTTParty.get(request_url, options)
          logger.info request_url
        end

        @products = []
        #combine results
        @results1.each { |result| @products.push(result)}
        @results2.each { |result| @products.push(result)}
        @results3.each { |result| @products.push(result)}

        #intialize counter
        @count_0_300 =0
        @count_300_600 =0
        @count_600_900 =0
        @count_900_1200 =0
        @count_1200_up =0

        #count number of items each range of price
        @products.each do |product|
          if product["price"].to_i >0
            if product["price"].to_i <300
              @count_0_300 = @count_0_300 + 1
            elsif product["price"].to_i <600
              @count_300_600 = @count_300_600 + 1
            elsif product["price"].to_i <900
              @count_600_900 = @count_600_900 + 1
            elsif product["price"].to_i <1200
              @count_900_1200 = @count_900_1200 + 1
            else
              @count_1200_up = @count_1200_up + 1
            end
          end
        #  logger.info "#{@count_0_300}  #{@count_300_600}  #{@count_600_900}  #{@count_900_1200}  #{@count_1200_up}"
        end
        # " "=>0 is used to adjust appearance
        @columnchartdata={"0~300"=>@count_0_300,"300~600"=>@count_300_600,"600~900"=>@count_600_900,
          "900~1200"=>@count_900_1200,"1200 up"=>@count_1200_up," "=>0}
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
