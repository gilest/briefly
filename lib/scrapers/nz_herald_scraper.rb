module Scrapers
  class NZHeraldScraper < Scrapers::ArticleScraper

    def self.can_handle_url?(url)
      !!(url =~ /nzherald\.co\.nz/)
    end

    def title
      return '' if document.css('h1.articleTitle').empty?
      document.css('h1.articleTitle').first.text.strip
    end

    def summary
      return '' if document.css('.articleBody p').empty?
      document.css('.articleBody p').first.text.strip
    end

    def exclude_images_matching
      [/mainSprite\.png/, /printLogo\.png/]
    end

  end
end