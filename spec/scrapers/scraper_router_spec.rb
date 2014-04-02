require 'spec_helper'

describe Scrapers::Router do

  it { expect(Scrapers::Router.scraper_for('foxnews.com.au')).to eq(Scrapers::ArticleScraper) }
  it { expect(Scrapers::Router.scraper_for('aljazeera.com')).to eq(Scrapers::AlJazeeraScraper) }
  it { expect(Scrapers::Router.scraper_for('radionz.co.nz')).to eq(Scrapers::RadioNZScraper) }
  it { expect(Scrapers::Router.scraper_for('bbc.com')).to eq(Scrapers::BBCScraper) }
  
end