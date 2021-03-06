require 'securerandom'

LENGTH = 6
class CreateShortLink
  attr_accessor :url, :short_link

  def initialize(url:)
    @url = url
    @short_link = SecureRandom.urlsafe_base64(LENGTH)
  end

  # In case of a collision attempt to recreate upto 10 times
  def recreate_on_collision(&does_collide)
    new_link = @short_link
    10.times do
      new_link = SecureRandom.urlsafe_base64(LENGTH)
      unless does_collide.call(new_link)
        @short_link = new_link
        break
      end
    end
  end

  def save
    DB[:short_links].insert(short_link: @short_link, url: @url)
  rescue Sequel::UniqueConstraintViolation
    recreate_on_collision do |link|
      DB[:short_links].where(short_link: link).count.positive?
    end
    DB[:short_links].insert(short_link: @short_link, url: @url)
  end
end
