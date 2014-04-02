module Scrapers
  class AlJazeeraScraper < Scrapers::ArticleScraper

    def self.can_handle_url?(url)
      !!(url =~ /aljazeera\.com/) # weird syntax here just converts regex match results to boolean
    end

    def exclude_images_matching
      [/201112310551561112_8\.jpg/]
    end

    def remote_image_url
      return '' if document.css('#mediaContainer img').empty?
      ensure_fully_qualified(document.css('#mediaContainer img').first.attr('src'))
    end

  end
end