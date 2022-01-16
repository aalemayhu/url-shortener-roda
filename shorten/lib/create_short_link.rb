require 'securerandom'

class CreateShortLink
  attr_accessor :url, :short_link

  def initialize(url:)
    @url = url
    @short_link = SecureRandom.urlsafe_base64(6)
  end
end
