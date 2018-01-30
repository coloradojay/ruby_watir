# frozen_string_literal: true

require_relative '../pageObjects/abstract_page'

class HomePage < AbstractPage
  def initialize(driver)
    super(driver)
  end

  def navigate_to_services
    find_link_element('Services').click
    ServicesPage.new(@@driver)
  end
end