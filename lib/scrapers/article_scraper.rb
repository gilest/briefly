module Scrapers
  class ArticleScraper

    require 'nokogiri'
    require 'open-uri'

    def initialize(url)
      @url = url
      @document = Nokogiri::HTML(open(@url)) # assigning the document to an instance variable is more performant
    end

    # the first h1 and h2 tags are reasonable assumptions for the title and summary respectively

    def title
      return '' if document.css('h1').empty?
      document.css('h1').first.text.strip
    end

    def summary
      return '' if document.css('h2').empty?
      document.css('h2').first.text.strip
    end

    def remote_image_url
      url = nil
      ideal_minimum_width = 661
      try_width = ideal_minimum_width

      while url == nil do
        # looking for images wider than try_width
        images_this_try = images_wider_than(try_width)
        # if there are any
        if images_this_try.length > 0
          potential_image_url = ensure_fully_qualified(images_this_try.first.attr('src'))
          # use the first one as our image
          url = potential_image_url unless exclude_image_url?(potential_image_url)
        end
        # if we can't find any images fall back to nothing
        url = '' if try_width <= 0
        # decrement width we're looking for
        try_width = try_width - 20
      end

      url
    end

    def exclude_image_url?(image_url)
      exclude_images_matching.each {|pattern| return true if image_url =~ pattern }
      return false
    end

    def exclude_images_matching
      []
    end

    def ensure_fully_qualified(url)
      return url if url =~ /http/
      return "#{base_url}#{url}"
    end

    def base_url
      uri = URI(@url)
      "#{uri.scheme}://#{uri.host}"
    end

    def scrape
      {
        title: title,
        summary: summary,
        remote_image_url: remote_image_url,
        link: @url
      }
    end

    def document
      @document
    end

    def images_wider_than(width)
      document.css('img').select{ |img| img[:width].to_i > width }
    end

  end
end