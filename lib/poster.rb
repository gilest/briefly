class Poster

  def initialize
    @graph = Koala::Facebook::API.new(oauth_access_token)
  end

end