# frozen_string_literal: true

require 'net/http'
require 'watir'

class AbstractPage
  @@driver = nil

  def initialize(driver)
    @@driver = driver
  end

  def navigate_to_home_page(url)
    @@driver.goto url
    HomePage.new(@@driver)
  end

  def navigate_to_services_page(url)
    @@driver.goto url
    ServicesPage.new(@@driver)
  end

  def get_page_url
    @@driver.url
  end

  def element_present?(el)
    el.visible? ? el : el.wait_until_present
  end

  def find_link_element(name)
    @@driver.link(:text, name.to_s)
  end

  def find_text_element(text)
    @@driver.text.include? text.to_s
  end

  def print_status_codes(link_text_arr)
    res_codes = []
    link_text_arr.each do |link_text|
      uri = URI(find_link_element(link_text).href)
      res = Net::HTTP.get_response(uri)
      puts "#{uri} has status code of #{res.code}"
      res_codes << res.code.to_s
    end
    res_codes
  end

  def close
    @@driver.close
  end
end