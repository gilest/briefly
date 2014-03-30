module Scrapers
  class StuffScraper < Scrapers::ArticleScraper

    def self.can_handle_url?(url)
      !!(url =~ /stuff\.co\.nz/)
    end

    def title
      return '' if document.css('.story_content_top h1').empty?
      document.css('.story_content_top h1').first.text.strip
    end

    def summary
      return '' if document.css('p').empty?
      document.css('p').first.text.strip
    end

    def remote_image_url
      return '' if document.css('.photoborder').empty?
      ensure_fully_qualified(document.css('.photoborder').first.attr('src'))
    end

  end
end