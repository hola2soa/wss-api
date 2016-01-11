require 'page-object'

class ItemPage
  include PageObject

  page_url "http://local:9292/show"

  text_field(:item_keyword,name: 'item')
  button(:search_button,name: 'submit' )
  table(:results_table,class: 'center')
end
