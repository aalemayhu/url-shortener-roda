require 'roda'

require_relative 'db'
require_relative 'cache'

class App < Roda
  route do |r|
    r.get String do |_path|
      redis_lookup = CACHE.get(_path)
      return r.redirect redis_lookup, 302 if redis_lookup

      db_lookup = DB[:short_links].where(short_link: _path)
      if db_lookup.empty?
        response.status = 404
        return r.halt
      end
      destination = db_lookup.first[:url]
      CACHE.set(_path, destination)
      r.redirect destination, 301
    end
  end
end
