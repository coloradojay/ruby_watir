# frozen_string_literal: true

require 'net/http'
require 'rspec'
require 'watir'

describe 'Site Tests' do
  browser = Watir::Browser.new :chrome
  home_page_url = env['HOME_PAGE_URL']
  services_page_url = env['SERVICES_PAGE_URL']
  discover_services_text = 'Discover our Services'.upcase

  before(:each) do
    @browser = browser
  end

  after(:all) do
    browser.close
  end

  it 'should verify the home page url matches' do
    @browser.goto home_page_url
    expect(@browser.url).to be == home_page_url
  end

  it 'should verify services page link is present' do
    service_tab_el = @browser.link(:text, 'Services').wait_until_present
    expect(service_tab_el.visible?).to be true
  end

  it 'should verify the services page url matches' do
    @browser.link(:text, 'Services').click
    expect(@browser.url).to eq services_page_url
  end

  context 'when on the services page' do
    it 'should verify the Discover our Services element is present' do
      @browser.goto services_page_url
      expect((@browser.text.include? discover_services_text.to_s)).to be true
    end

    it 'should verify the services page links produce a 200 status code' do
      discover_service_links_text = ['Affordable Care Act Compliance (ACA)',
                                     'Work Opportunity Tax Credit (WOTC)',
                                     'Research & Development Tax Credit (R&D)',
                                     'Other Services']
      discover_service_links_text.each do |link_text|
        uri = URI(browser.link(:text, link_text).href)
        res = Net::HTTP.get_response(uri)
        expect(res.code).to eq '200'
        puts "#{uri} has status code of #{res.code}"
      end
    end
  end
end