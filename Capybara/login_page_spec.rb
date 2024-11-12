# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

Capybara.default_driver = :selenium_chrome

RSpec.describe 'SauceDemo E2E Tests' do
  before(:each) do
    @driver = Capybara::Session.new(:selenium_chrome)
    @url = 'https://www.saucedemo.com'
    @driver.visit @url
  end

  context 'Login Tests' do
    usernames = ['error_user', 'locked_out_user', 'standard_user']
    password = 'secret_sauce'

    usernames.each do |username|
      if username == 'error_user'
        it "should show error message when logging in as #{username}" do
          log_in_to_account(username, 'incorrect_password')
          expect_error_message("Epic sadface: Username and password do not match any user in this service")
        end
      elsif username == 'locked_out_user'
        it "should show error message when logging in as #{username}" do
          log_in_to_account(username, password)
          expect_error_message("Epic sadface: Sorry, this user has been locked out.")
        end
      else
        it "should successfully log in as #{username}" do
          log_in_to_account(username, password)
          expect(@driver).to have_selector('[data-test="title"]', text: 'Products')
        end
      end
    end
  end

  context 'Shopping Cart Tests' do
    it 'should add two items to the cart after successful login' do
      log_in_to_account('standard_user', 'secret_sauce')

      add_product_to_cart('[data-test="add-to-cart-sauce-labs-backpack"]')

      add_product_to_cart('[data-test="add-to-cart-sauce-labs-fleece-jacket"]')

      expect(@driver).to have_selector('[data-test="shopping-cart-badge"]', text: '2')
    end
  end

  def log_in_to_account(username, password)
    @driver.fill_in 'user-name', with: username
    @driver.fill_in 'password', with: password
    @driver.click_button('Login')
  end

  def expect_error_message(message)
    expect(@driver).to have_selector('[data-test="error"]', text: message)
  end

  def add_product_to_cart(product_selector)
    add_button = @driver.find(product_selector)
    add_button.click if add_button
  end

  after(:each) do
    @driver.visit @url
  end
end
