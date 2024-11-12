# frozen_string_literal: true

require 'capybara'
require 'rspec'
require 'selenium-webdriver'
require 'webdrivers'

Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome_headless 
Capybara.app_host = 'https://www.saucedemo.com/'

RSpec.configure do |config|
  config.add_formatter 'html', 'results.html' 

  config.after(:each) do |example|
    if example.exception
      
      Dir.mkdir('screenshots') unless Dir.exist?('screenshots')

      time = Time.now.strftime('%Y-%m-%d_%H_%M_%S')
      filename = "screenshots/#{time}_#{example.description.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')}.png"

      Capybara.page.driver.browser.save_screenshot(filename)
    end
  end
end

Capybara::Selenium::Driver.class_eval do
  def quit
  end
end
