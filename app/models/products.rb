#!/usr/bin/env ruby
require 'queenshop'
require 'json'

##
# Stores prodcut name and price in a json list
#
# Example:
#   b = ItemList.new
#   b['red blouse'] = '380'
#   puts b.to_json
class ItemList
  def []=(title, price)
    @products ||= {}
    @products[title] = price
  end

  def to_json
    @products.map do |item, price|
      { 'item' => item, 'price' => price }
    end.to_json
  end
end

##
# Loads and returns items with their prices
class Products
  attr_reader :products
  attr_reader :prices
  def initialize(item = '', price = '', pages = '')
    params = []
    @products = []
    @prices = []
    # should encode quotes and special chars here
    # to avoid code injection
    params.push("price=#{price}") if !price.empty?
    params.push("item=#{item}") if !item.empty?
    params.push("pages=#{pages}") if !pages.empty?
    @products = load_items(params)
  end

  def to_json
    @products.map do |item|
      { 'item' => item[:item], 'price' => item[:price] }
    end.to_json
  end

  private

  def load_items(params = [])
    item_list = ItemList.new
    scraper = QueenShopScraper::Filter.new
    scraper.scrape(params).each do |item|
      item_list[item[:title]] = item[:price]
      @prices.push(item[:price])
    end
  end
end
