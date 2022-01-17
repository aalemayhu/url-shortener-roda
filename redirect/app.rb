require 'roda'

require_relative 'db'

class App < Roda
  route do |r|
    r.get String do |_path|
      lookup = DB[:short_links].where(short_link: _path)
      return r.halt 404 if lookup.empty?

      destination = lookup.first
      r.redirect destination[:url], 301
    end
  end
end
