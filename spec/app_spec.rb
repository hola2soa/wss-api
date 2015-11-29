#!/usr/bin/env ruby
require_relative 'spec_helper'
require 'json'

describe 'Shopping for items' do
  before do
    unless @browser
      @headless = Headless.new
      @browser = Watir::Browser.new
    end
    @browser.goto 'localhost:9292'
  end

  describe 'Go to home page' do
    it 'finds the title' do
      @browser.title.must_equal 'Hola'
    end
  end
  describe 'Searching for an item' do
    it 'finds an item' do
      @browser.text_field(name: 'item').set 's'
      @browser.button(name: 'submit').click
      @browser.table(class: 'center').rows.count.must_be :>=, 30
    end
  end

  after do
    @browser.close
    # @headless.destroy
    # destroy causes test to hang need to dig into this issue
  end
end
