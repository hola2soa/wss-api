#!/usr/bin/env ruby
require_relative 'spec_helper'
require 'json'

describe 'Shopping for items' do
  include PageObject::PageFactory

  before do
    unless @browser
      @headless = Headless.new
      @browser = Watir::Browser.new
    end
    @browser.goto 'localhost:9292'
  end

  describe 'Go to home page' do
    it 'finds the title' do
      visit HomePage do |page|
        page.homepage_title.must_equal 'Hola'   #  @browser.title.must_equal 'Hola'
      end
    end
  end

  describe 'Searching for an item' do
    it 'finds an item' do
      visit ItemPage do |page|
        page.item_keyword.set 's'
        page.search_button.click
        page.results_table.rows.count.must_be :>=, 30
      end
    end
  end

  after do
    @browser.close
    # @headless.destroy
    # destroy causes test to hang need to dig into this issue
  end
end
