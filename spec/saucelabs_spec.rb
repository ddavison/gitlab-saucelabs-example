# frozen_string_literal: true

require 'selenium-webdriver'

describe 'GitLab' do
  let(:capabilities) do
    {
      browser_name: :chrome,
      browser_version: '77.0',
      platform_name: 'macOS 10.14',
      'sauce:options': {
        username: ENV['SAUCELABS_USERNAME'],
        accesskey: ENV['SAUCELABS_ACCESS_KEY'],
        tags: 'gitlab-saucelabs-example',
        name: 'gitlab-saucelabs-example',
        build: ENV['CI_JOB_ID']
      }
    }
  end

  let(:driver) do
    Selenium::WebDriver.for :remote,
                            url: 'http://ondemand.saucelabs.com:80/wd/hub',
                            desired_capabilities: capabilities
  end

  after do
    driver.quit
  end

  it 'works with SauceLabs' do
    driver.get('https://www.google.com/ncr')
    driver.find_element(name: 'q').send_keys 'gitlab saucelabs', :return
    expect(driver.title).to eq('gitlab saucelabs - Google Search')
  end
end
