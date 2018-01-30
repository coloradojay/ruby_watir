# frozen_string_literal: true

require 'dotenv/load'
require 'rspec'
require 'watir'

require_relative '../pageObjects/abstract_page'
require_relative '../pageObjects/home_page'
require_relative '../pageObjects/services_page'

describe 'My behaviour' do

  home_page_url = env['HOME_PAGE_URL']
  services_page_url = env['SERVICES_PAGE_URL']
  discover_service_links_text = ['Affordable Care Act Compliance (ACA)',
                                 'Work Opportunity Tax Credit (WOTC)',
                                 'Research & Development Tax Credit (R&D)',
                                 'Other Services']
  app = nil

  before(:all) do
    app = AbstractPage.new((Watir::Browser.new :chrome))
    app.navigate_to_home_page home_page_url
  end

  after(:all) do
    app.close
  end

  it 'should verify the home page url matches' do
    expect(app.get_page_url).to eq home_page_url
  end

  it 'should verify the services page link is present' do
    el = app.find_link_element('Services')
    expect(app.element_present?(el).visible?).to be true
  end

  it 'should click the services link if available' do
    app.find_link_element('Services').click
    expect(app.get_page_url).to eq services_page_url
  end

  context 'when on the services page' do
    before(:each) do
      app.navigate_to_services_page(services_page_url)
    end

    it 'should verify the Discover our Services text' do
      expect(app.find_text_element('Discover our Services'.upcase)).to be true
    end

    it 'should verify the services page links produce a 200 status code' do
      res_codes = app.print_status_codes(discover_service_links_text)
      res_codes.each do |code|
        expect(code.to_s).to eq '200'
      end
    end
  end
end