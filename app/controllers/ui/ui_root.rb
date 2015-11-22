module UI
  module Root
    def self.registered(app)
      get_root = lambda do
        redirect "/show"
      end
      app.get '/?', &get_root
    end
  end
end
