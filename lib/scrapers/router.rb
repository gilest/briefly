require 'scrapers/article_scraper'
require 'scrapers/bbc_scraper'
require 'scrapers/nz_herald_scraper'
require 'scrapers/radio_nz_scraper'
require 'scrapers/stuff_scraper'

module Scrapers
  class Router

    def self.scraper_for(url)
      selected_scraper = nil
      # iterate over all subclasses of the article scraper
      # and select one if it can handle the url
      ArticleScraper.subclasses.each { |scraper| selected_scraper = scraper if scraper.can_handle_url?(url) }
      # if none of our other scrapers think they can handle this url
      # then fall back to the generic article scraper 
      selected_scraper ||= ArticleScraper
    end

  end
end