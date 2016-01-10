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

      options =  { headers: { 'Content-Type' => 'application/json' } }
      request_url = get_api_url("?store=queenshop")
      @results1 = HTTParty.get(request_url, options)
      request_url = get_api_url("?store=stylemooncat")
      @results2 = HTTParty.get(request_url, options)

      #combine result
      @products=[]
      @results1.each {|result| @products.push(result) if result["price"].to_i>0}
      @results2.each {|result| @products.push(result) if result["price"].to_i>0}

      logger.info 'load show'
      slim :main_pane
    end

    app_get_show_item = lambda do
      begin
        @item = params[:item] # @item is keyword or category
        logger.info @item

        options =  { headers: { 'Content-Type' => 'application/json' }}

        if session[:results]
          @results = session[:results]
          session[:results] = nil
        elsif @item == 'pants' #category
          request_url = get_api_url("?store=queenshop&category=pants")
          @results1 = HTTParty.get(request_url, options)
        elsif @item == 'popular' #category
          request_url = get_api_url("?store=queenshop&category=popular")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&category=popular")
          @results2 = HTTParty.get(request_url, options)
        elsif @item == 'accessories' #category
          request_url = get_api_url("?store=queenshop&category=accessories")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&category=accessories")
          @results2 = HTTParty.get(request_url, options)
        elsif @item == 'tops' #category
          request_url = get_api_url("?store=queenshop&category=tops")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&category=tops")
          @results2 = HTTParty.get(request_url, options)
        elsif @item == 'latest' #category
          request_url = get_api_url("?store=queenshop&category=latest")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&category=latest")
          @results2 = HTTParty.get(request_url, options)
        else #keyword
          request_url = get_api_url("?store=queenshop&keyword=#{URI.escape(@item)}")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=joyceshop&keyword=#{URI.escape(@item)}")
          @results2 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&keyword=#{URI.escape(@item)}")
          @results3 = HTTParty.get(request_url, options)
        end

        @products = []
        #combine results
        @results1.each { |result| @products.push(result)} if @results1!=nil
        @results2.each { |result| @products.push(result)} if @results2!=nil
        @results3.each { |result| @products.push(result)} if @results3!=nil

        #intialize counter
        @count_0_200 =0
        @count_200_400 =0
        @count_400_600 =0
        @count_600_800 =0
        @count_800_1000 =0
        @count_1000_up =0

        #count number of items each range of price
        @products.each do |product|
          if product["price"].to_i >0
            if product["price"].to_i <200
              @count_0_200 += 1
            elsif product["price"].to_i <400
              @count_200_400 += 1
            elsif product["price"].to_i <600
              @count_400_600 += 1
            elsif product["price"].to_i <800
              @count_600_800 += 1
            elsif product["price"].to_i <1000
              @count_800_1000 += 1
            else
              @count_1000_up += 1
            end
          end
        #  logger.info "#{@count_0_300}  #{@count_300_600}  #{@count_600_900}  #{@count_900_1200}  #{@count_1200_up}"
        end
        # " "=>0 is used to adjust appearance
        @columnchartdata={"0~200"=>@count_0_200,"200~400"=>@count_200_400,"400~600"=>@count_400_600,
          "600~800"=>@count_600_800,"800~1000"=>@count_800_1000,"1000 up"=>@count_1000_up," "=>0}
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
