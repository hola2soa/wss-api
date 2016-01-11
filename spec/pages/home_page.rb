require 'page-object'

class HomePage
  include PageObject

  page_url "http://localhost:9292/show"

  title(:homepage_title,text: 'homepage_title')
end
