require 'spec_helper'

describe ScraperRouter do

  it { expect(ScraperRouter.scraper_for('foxnews.com.au')).to eq(ArticleScraper) }
  it { expect(ScraperRouter.scraper_for('radionz.co.nz')).to eq(RadioNZScraper) }
  
end