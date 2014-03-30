class RadioNZScraper < ArticleScraper

  def self.can_handle_url?(url)
    !!(url =~ /radionz\.co\.nz/) # weird syntax here just converts regex match results to boolean
  end

  def title
    return '' if document.css('h2').empty?
    document.css('h2').first.text.strip
  end

  def summary
    return '' if document.css('strong').empty?
    document.css('strong').first.text.strip
  end

  def exclude_images_matching
    [/\/x\/logos\//]
  end

end