Dir.glob('./app/controllers/*/*.rb').each { |file| require file }

class SinatraApp < Sinatra::Base
	register Sinatra::Namespace

	namespace '/' do
		register UI::Root
	end

  namespace '/show' do
		register UI::Show
	end

	namespace '/query' do
		register UI::Query
	end
end
