module HasShortenedUrl
  extend ActiveSupport::Concern

  included do
    after_save :ensure_shortener_string
  end

  def ensure_shortener_string
    if shortener_string.nil?
      string = random_string(10)
      # in the unlikely case that the url isn't unique, try again until it is
      while Article.exists?(shortener_string: string) do
        string = random_string(10)
      end
      update_column :shortener_string, string
    end
  end

  def random_string(length)
    rand(36**length).to_s(36)
  end

  def shortened_url
    "#{Briefly::Application.config.shortener_host}/#{shortener_string}"
  end

end