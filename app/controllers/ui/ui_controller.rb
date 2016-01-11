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
      request_url = get_api_url("?store=joyceshop")
      @results3 = HTTParty.get(request_url, options)

      if @results1[0]["title"] == nil && @results2[1]["title"] == nil && @results3[1]["title"] == nil
        @results1 =[{"title"=>"尖頭壓紋平底跟鞋*2色", "price"=>"540", "images"=>["http://www.stylemooncat.com.tw/photo/09070006/09070006.jpg"], "link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24732"},{"title"=>"純色彈性窄管褲*2色","price"=>380,"images"=>["http://www.stylemooncat.com.tw/photo/05020056/05020056.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24135"}]
        @results1.push({"title"=>"高挺及膝中長大衣*3色","price"=>980,"images"=>["http://www.stylemooncat.com.tw/photo/04090001/04090001.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=25601-dn"},{"title"=>"羅紋立領合身毛衣*4色","price"=>330,"images"=>["http://www.stylemooncat.com.tw/photo/01110084/01110084.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24724"})
        @results1.push({"title"=>"迷彩側開衩毛呢長上衣", "price"=>550, "images"=>["https://queenshop.com.tw/photo/01092774/01092774.jpg", "https://queenshop.com.tw/photo/01092774/01092774-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01092774"},{"title"=>"DAFFY DUCK仿舊連帽上...", "price"=>590, "images"=>["https://queenshop.com.tw/photo/01035002/01035002.jpg", "https://queenshop.com.tw/photo/01035002/01035002-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01035002"})
        @results1.push({"title"=>"黑白配色剪接內刷毛落肩上衣", "price"=>490, "images"=>["https://queenshop.com.tw/photo/01035159/01035159.jpg", "https://queenshop.com.tw/photo/01035159/01035159-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01035159"},{"title"=>"後開釦造型長上衣 兩色售", "price"=>350, "images"=>["https://queenshop.com.tw/photo/01092359/01092359.jpg", "https://queenshop.com.tw/photo/01092359/01092359-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01092359"})
        @results1.push({"title"=>"高領混織落肩上衣", "price"=>190, "images"=>["https://queenshop.com.tw/photo/01092516/01092516.jpg", "https://queenshop.com.tw/photo/01092516/01092516-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01092516"},{"title"=>"撞色色塊造型長版針織衫", "price"=>530, "images"=>["https://queenshop.com.tw/photo/01011700/01011700.jpg", "https://queenshop.com.tw/photo/01011700/01011700-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01011700"})
        @results1.push({"title"=>"格紋鬆緊休閒長褲 兩色售 S/...", "price"=>390, "images"=>["https://queenshop.com.tw/photo/04100852/04100852.jpg", "https://queenshop.com.tw/photo/04100852/04100852-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100852"},{"title"=>"素色百搭棉質內搭褲 四色售 S...", "price"=>250, "images"=>["https://queenshop.com.tw/photo/04040398/04040398.jpg", "https://queenshop.com.tw/photo/04040398/04040398-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040398"})
        @results1.push({"title"=>"素面窄版男友牛仔褲 兩色售 S...", "price"=>550, "images"=>["https://queenshop.com.tw/photo/04010856/04010856.jpg", "https://queenshop.com.tw/photo/04010856/04010856-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010856"},{"title"=>"單釦顯瘦合身窄管褲 三色售 S...", "price"=>390, "images"=>["https://queenshop.com.tw/photo/04100860/04100860.jpg", "https://queenshop.com.tw/photo/04100860/04100860-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100860"})
        @results1.push({"title"=>"造型口袋打摺斜紋西裝褲 兩色售...", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04030157/04030157.jpg", "https://queenshop.com.tw/photo/04030157/04030157-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04030157"}, {"title"=>"鬆緊寬版男友牛仔褲 S/M", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04010795/04010795.jpg", "https://queenshop.com.tw/photo/04010795/04010795-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010795"})
        @results1.push({"title"=>"鬆緊傘狀圓擺褲裙 S/M", "price"=>290, "images"=>["https://queenshop.com.tw/photo/04060198/04060198.jpg", "https://queenshop.com.tw/photo/04060198/04060198-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04060198"}, {"title"=>"溫暖內鋪毛彈性內搭褲 三色售", "price"=>290, "images"=>["https://queenshop.com.tw/photo/04040412/04040412.jpg", "https://queenshop.com.tw/photo/04040412/04040412-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040412"})
        @results1.push({"title"=>"洗水破損鬆緊休閒長褲 兩色售", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04100857/04100857.jpg", "https://queenshop.com.tw/photo/04100857/04100857-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100857"}, {"title"=>"淺刷色破損男友牛仔褲 S/M", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04010791/04010791.jpg", "https://queenshop.com.tw/photo/04010791/04010791-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010791"})
        @results1.push({"title"=>"黑色洗水牛仔短褲 S/M/L", "price"=>195, "images"=>["https://queenshop.com.tw/photo/04010838/04010838.jpg", "https://queenshop.com.tw/photo/04010838/04010838-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010838"}, {"title"=>"車線造型棉質內搭褲 三色售", "price"=>250, "images"=>["https://queenshop.com.tw/photo/04040428/04040428.jpg", "https://queenshop.com.tw/photo/04040428/04040428-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040428"})
        @results1.push({"title"=>"反摺綁帶鬆緊老爺褲 三色售", "price"=>550, "images"=>["https://queenshop.com.tw/photo/04100849/04100849.jpg", "https://queenshop.com.tw/photo/04100849/04100849-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100849"}, {"title"=>"打摺造型磨毛長褲 兩色售 S/...", "price"=>450, "images"=>["https://queenshop.com.tw/photo/04100875/04100875.jpg", "https://queenshop.com.tw/photo/04100875/04100875-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100875"})
        @results1.push({"title"=>"灰色刷破水洗牛仔窄管褲 S/M...", "price"=>680, "images"=>["https://queenshop.com.tw/photo/04100824/04100824.jpg", "https://queenshop.com.tw/photo/04100824/04100824-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100824"}, {"title"=>"前百摺造型褲裙 三色售", "price"=>290, "images"=>["https://queenshop.com.tw/photo/04060221/04060221.jpg", "https://queenshop.com.tw/photo/04060221/04060221-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04060221"})
      end

      #combine result
      @products=[]
      @results1.each {|result| @products.push(result) if result["price"].to_i>0}
      @results2.each {|result| @products.push(result) if result["price"].to_i>0}
      @results3.each {|result| @products.push(result) if result["price"].to_i>0}

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
          request_url = get_api_url("?store=stylemooncat&category=pants")
          @results2 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=joyceshop&category=pants")
          @results3 = HTTParty.get(request_url, options)

          if @results1[0]["title"] == nil && @results2[1]["title"] == nil && @results3[1]["title"] == nil
            @results1 =[{"title"=>"溫暖內鋪毛彈性內搭褲 三色售", "price"=>290, "images"=>["https://queenshop.com.tw/photo/04040412/04040412.jpg", "https://queenshop.com.tw/photo/04040412/04040412-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040412"},{"title"=>"純色彈性窄管褲*2色","price"=>380,"images"=>["http://www.stylemooncat.com.tw/photo/05020056/05020056.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24135"}]
            @results1.push({"title"=>"格紋鬆緊休閒長褲 兩色售 S/...", "price"=>390, "images"=>["https://queenshop.com.tw/photo/04100852/04100852.jpg", "https://queenshop.com.tw/photo/04100852/04100852-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100852"},{"title"=>"素色百搭棉質內搭褲 四色售 S...", "price"=>250, "images"=>["https://queenshop.com.tw/photo/04040398/04040398.jpg", "https://queenshop.com.tw/photo/04040398/04040398-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040398"})
            @results1.push({"title"=>"素面窄版男友牛仔褲 兩色售 S...", "price"=>550, "images"=>["https://queenshop.com.tw/photo/04010856/04010856.jpg", "https://queenshop.com.tw/photo/04010856/04010856-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010856"},{"title"=>"單釦顯瘦合身窄管褲 三色售 S...", "price"=>390, "images"=>["https://queenshop.com.tw/photo/04100860/04100860.jpg", "https://queenshop.com.tw/photo/04100860/04100860-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100860"})
            @results1.push({"title"=>"造型口袋打摺斜紋西裝褲 兩色售...", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04030157/04030157.jpg", "https://queenshop.com.tw/photo/04030157/04030157-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04030157"}, {"title"=>"鬆緊寬版男友牛仔褲 S/M", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04010795/04010795.jpg", "https://queenshop.com.tw/photo/04010795/04010795-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010795"})
            @results1.push({"title"=>"洗水破損鬆緊休閒長褲 兩色售", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04100857/04100857.jpg", "https://queenshop.com.tw/photo/04100857/04100857-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100857"}, {"title"=>"淺刷色破損男友牛仔褲 S/M", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04010791/04010791.jpg", "https://queenshop.com.tw/photo/04010791/04010791-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010791"})
            @results1.push({"title"=>"黑色洗水牛仔短褲 S/M/L", "price"=>195, "images"=>["https://queenshop.com.tw/photo/04010838/04010838.jpg", "https://queenshop.com.tw/photo/04010838/04010838-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010838"}, {"title"=>"車線造型棉質內搭褲 三色售", "price"=>250, "images"=>["https://queenshop.com.tw/photo/04040428/04040428.jpg", "https://queenshop.com.tw/photo/04040428/04040428-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040428"})
            @results1.push({"title"=>"反摺綁帶鬆緊老爺褲 三色售", "price"=>550, "images"=>["https://queenshop.com.tw/photo/04100849/04100849.jpg", "https://queenshop.com.tw/photo/04100849/04100849-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100849"}, {"title"=>"打摺造型磨毛長褲 兩色售 S/...", "price"=>450, "images"=>["https://queenshop.com.tw/photo/04100875/04100875.jpg", "https://queenshop.com.tw/photo/04100875/04100875-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100875"})
            @results1.push({"title"=>"灰色刷破水洗牛仔窄管褲 S/M...", "price"=>680, "images"=>["https://queenshop.com.tw/photo/04100824/04100824.jpg", "https://queenshop.com.tw/photo/04100824/04100824-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100824"}, {"title"=>"前百摺造型褲裙 三色售", "price"=>290, "images"=>["https://queenshop.com.tw/photo/04060221/04060221.jpg", "https://queenshop.com.tw/photo/04060221/04060221-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04060221"})
          end
        elsif @item == 'popular' #category
          request_url = get_api_url("?store=queenshop&category=popular")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&category=popular")
          @results2 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=joyceshop&category=popular")
          @results3 = HTTParty.get(request_url, options)

          if @results1[0]["title"] == nil && @results2[1]["title"] == nil && @results3[1]["title"] == nil
            @results1 =[{"title"=>"溫暖內鋪毛彈性內搭褲 三色售", "price"=>290, "images"=>["https://queenshop.com.tw/photo/04040412/04040412.jpg", "https://queenshop.com.tw/photo/04040412/04040412-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040412"},{"title"=>"純色彈性窄管褲*2色","price"=>380,"images"=>["http://www.stylemooncat.com.tw/photo/05020056/05020056.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24135"}]
            @results1.push({"title"=>"高挺及膝中長大衣*3色","price"=>980,"images"=>["http://www.stylemooncat.com.tw/photo/04090001/04090001.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=25601-dn"},{"title"=>"羅紋立領合身毛衣*4色","price"=>330,"images"=>["http://www.stylemooncat.com.tw/photo/01110084/01110084.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24724"})
            @results1.push({"title"=>"格紋鬆緊休閒長褲 兩色售 S/...", "price"=>390, "images"=>["https://queenshop.com.tw/photo/04100852/04100852.jpg", "https://queenshop.com.tw/photo/04100852/04100852-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100852"},{"title"=>"素色百搭棉質內搭褲 四色售 S...", "price"=>250, "images"=>["https://queenshop.com.tw/photo/04040398/04040398.jpg", "https://queenshop.com.tw/photo/04040398/04040398-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040398"})
            @results1.push({"title"=>"反摺綁帶鬆緊老爺褲 三色售", "price"=>550, "images"=>["https://queenshop.com.tw/photo/04100849/04100849.jpg", "https://queenshop.com.tw/photo/04100849/04100849-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100849"}, {"title"=>"打摺造型磨毛長褲 兩色售 S/...", "price"=>450, "images"=>["https://queenshop.com.tw/photo/04100875/04100875.jpg", "https://queenshop.com.tw/photo/04100875/04100875-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100875"})
            @results1.push({"title"=>"灰色刷破水洗牛仔窄管褲 S/M...", "price"=>680, "images"=>["https://queenshop.com.tw/photo/04100824/04100824.jpg", "https://queenshop.com.tw/photo/04100824/04100824-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100824"}, {"title"=>"前百摺造型褲裙 三色售", "price"=>290, "images"=>["https://queenshop.com.tw/photo/04060221/04060221.jpg", "https://queenshop.com.tw/photo/04060221/04060221-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04060221"})
          end
        elsif @item == 'accessories' #category
          request_url = get_api_url("?store=queenshop&category=accessories")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&category=accessories")
          @results2 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=joyceshop&category=accessories")
          @results3 = HTTParty.get(request_url, options)

        elsif @item == 'tops' #category
          request_url = get_api_url("?store=queenshop&category=tops")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&category=tops")
          @results2 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=joyceshop&category=tops")
          @results3 = HTTParty.get(request_url, options)

          if @results1[0]["title"] == nil && @results2[1]["title"] == nil && @results3[1]["title"] == nil
                @results1=[{"title"=>"高挺及膝中長大衣*3色","price"=>980,"images"=>["http://www.stylemooncat.com.tw/photo/04090001/04090001.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=25601-dn"},{"title"=>"羅紋立領合身毛衣*4色","price"=>330,"images"=>["http://www.stylemooncat.com.tw/photo/01110084/01110084.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24724"}]
                @results1.push({"title"=>"迷彩側開衩毛呢長上衣", "price"=>550, "images"=>["https://queenshop.com.tw/photo/01092774/01092774.jpg", "https://queenshop.com.tw/photo/01092774/01092774-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01092774"},{"title"=>"DAFFY DUCK仿舊連帽上...", "price"=>590, "images"=>["https://queenshop.com.tw/photo/01035002/01035002.jpg", "https://queenshop.com.tw/photo/01035002/01035002-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01035002"})
                @results1.push({"title"=>"黑白配色剪接內刷毛落肩上衣", "price"=>490, "images"=>["https://queenshop.com.tw/photo/01035159/01035159.jpg", "https://queenshop.com.tw/photo/01035159/01035159-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01035159"},{"title"=>"後開釦造型長上衣 兩色售", "price"=>350, "images"=>["https://queenshop.com.tw/photo/01092359/01092359.jpg", "https://queenshop.com.tw/photo/01092359/01092359-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01092359"})
                @results1.push({"title"=>"高領混織落肩上衣", "price"=>190, "images"=>["https://queenshop.com.tw/photo/01092516/01092516.jpg", "https://queenshop.com.tw/photo/01092516/01092516-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01092516"},{"title"=>"撞色色塊造型長版針織衫", "price"=>530, "images"=>["https://queenshop.com.tw/photo/01011700/01011700.jpg", "https://queenshop.com.tw/photo/01011700/01011700-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01011700"})
                @results1.push({"title"=>"復古小Ｖ領直條紋毛料上衣 兩色...", "price"=>195, "images"=>["https://queenshop.com.tw/photo/01092488/01092488.jpg", "https://queenshop.com.tw/photo/01092488/01092488-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=01092488"})
          end
        elsif @item == 'latest' #category
          request_url = get_api_url("?store=queenshop&category=latest")
          @results1 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=stylemooncat&category=latest")
          @results2 = HTTParty.get(request_url, options)
          request_url = get_api_url("?store=joyceshop&category=latest")
          @results3 = HTTParty.get(request_url, options)

          if @results1[0]["title"] == nil && @results2[1]["title"] == nil && @results3[1]["title"] == nil
            @results1 =[{"title"=>"溫暖內鋪毛彈性內搭褲 三色售", "price"=>290, "images"=>["https://queenshop.com.tw/photo/04040412/04040412.jpg", "https://queenshop.com.tw/photo/04040412/04040412-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040412"},{"title"=>"純色彈性窄管褲*2色","price"=>380,"images"=>["http://www.stylemooncat.com.tw/photo/05020056/05020056.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24135"}]
            @results1.push({"title"=>"高挺及膝中長大衣*3色","price"=>980,"images"=>["http://www.stylemooncat.com.tw/photo/04090001/04090001.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=25601-dn"},{"title"=>"羅紋立領合身毛衣*4色","price"=>330,"images"=>["http://www.stylemooncat.com.tw/photo/01110084/01110084.jpg"],"link"=>"http://www.stylemooncat.com.tw/PDContent.asp?yano=24724"})
            @results1.push({"title"=>"格紋鬆緊休閒長褲 兩色售 S/...", "price"=>390, "images"=>["https://queenshop.com.tw/photo/04100852/04100852.jpg", "https://queenshop.com.tw/photo/04100852/04100852-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100852"},{"title"=>"素色百搭棉質內搭褲 四色售 S...", "price"=>250, "images"=>["https://queenshop.com.tw/photo/04040398/04040398.jpg", "https://queenshop.com.tw/photo/04040398/04040398-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04040398"})
            @results1.push({"title"=>"素面窄版男友牛仔褲 兩色售 S...", "price"=>550, "images"=>["https://queenshop.com.tw/photo/04010856/04010856.jpg", "https://queenshop.com.tw/photo/04010856/04010856-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010856"},{"title"=>"單釦顯瘦合身窄管褲 三色售 S...", "price"=>390, "images"=>["https://queenshop.com.tw/photo/04100860/04100860.jpg", "https://queenshop.com.tw/photo/04100860/04100860-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04100860"})
            @results1.push({"title"=>"造型口袋打摺斜紋西裝褲 兩色售...", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04030157/04030157.jpg", "https://queenshop.com.tw/photo/04030157/04030157-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04030157"}, {"title"=>"鬆緊寬版男友牛仔褲 S/M", "price"=>490, "images"=>["https://queenshop.com.tw/photo/04010795/04010795.jpg", "https://queenshop.com.tw/photo/04010795/04010795-h.jpg"], "link"=>"https://queenshop.com.tw/PDContent.asp?yano=04010795"})
          end
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
