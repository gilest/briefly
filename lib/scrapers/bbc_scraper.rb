module Scrapers
  class BBCScraper < Scrapers::ArticleScraper

    def self.can_handle_url?(url)
      !!(url =~ /bbc\.com/) # weird syntax here just converts regex match results to boolean
    end

    def summary
      return '' if document.css('.introduction').empty?
      document.css('.introduction').first.text.strip
    end

    def exclude_images_matching
      [/\/x\/logos\//]
    end

  end
end